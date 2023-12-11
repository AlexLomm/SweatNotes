import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:sweatnotes/features/settings/show_archived_switcher.dart';
import 'package:tuple/tuple.dart';

import '../../router/router.dart';
import '../../shared/services/shared_preferences.dart';
import '../../widgets/button_dropdown_menu.dart';
import '../../widgets/empty_page_placeholder.dart';
import '../../widgets/expandable_timer/expandable_timer.dart';
import '../../widgets/go_back_button.dart';
import '../../widgets/layout.dart';
import '../auth/services/auth_service.dart';
import '../settings/compact_mode_switcher.dart';
import '../settings/edit_mode_switcher.dart';
import '../settings/exercise_reactions_switcher.dart';
import '../settings/timer_switcher.dart';
import 'custom_flexible_space_bar.dart';
import 'data/models_client/training_block_client.dart';
import 'services/training_block_details_stream.dart';
import 'widget_params.dart';
import 'widgets/horizontally_scrollable_exercise_labels/horizontally_scrollable_exercise_labels.dart';
import 'widgets/horizontally_scrollable_exercises.dart';

class TrainingBlockScreen extends ConsumerStatefulWidget {
  final String trainingBlockId;

  const TrainingBlockScreen({
    super.key,
    required this.trainingBlockId,
  });

  @override
  ConsumerState createState() => _TrainingBlockScreenState();
}

class _TrainingBlockScreenState extends ConsumerState<TrainingBlockScreen> with RouteAware {
  late RouteObserver _routeObserver;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _routeObserver = ref.read(routeObserverProvider);

    _routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    // calling ref.read causes the "Looking up a
    // deactivated widget's ancestor is unsafe" error
    _routeObserver.unsubscribe(this);

    super.dispose();
  }

  @override
  void didPush() {
    final prefs = ref.read(prefsProvider);

    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final String trainingBlockId = routeArgs['trainingBlockId'];

    prefs.setString('initialLocation', '/$trainingBlockId');
  }

  @override
  void didPop() {
    final prefs = ref.read(prefsProvider);
    final editModeSwitcher = ref.watch(editModeSwitcherProvider.notifier);

    // this is needed to prevent an error being
    // thrown by riverpod when provider is modified
    // from inside the lifecycle hook
    Future(() => editModeSwitcher.disable());

    prefs.setString('initialLocation', '/');
  }

  @override
  Widget build(BuildContext context) {
    final authService = ref.watch(authServiceProvider);
    final showArchivedSwitcher = ref.watch(showArchivedSwitcherProvider);
    final data =
        ref.watch(trainingBlockDetailsStreamProvider(widget.trainingBlockId, includeArchived: showArchivedSwitcher));
    final isTimerEnabled = ref.watch(timerSwitcherProvider);

    return data.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (Object error, StackTrace stackTrace) {
        WidgetsBinding.instance.addPostFrameCallback((_) => authService.signOut());

        return Center(child: Text(error.toString()));
      },
      data: (trainingBlock) {
        if (trainingBlock == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) => context.goNamed(RouteNames.home));

          return const Center(child: CircularProgressIndicator());
        }

        return Layout(
          isScrollable: false,
          isAppBarVisible: false,
          padding: EdgeInsets.zero,
          floatingActionButton: IgnorePointer(
            ignoring: !isTimerEnabled,
            child: AnimatedOpacity(
              duration: WidgetParams.animationDuration,
              curve: WidgetParams.animationCurve,
              opacity: isTimerEnabled ? 1 : 0,
              child: const ExpandableTimer(),
            ),
          ),
          child: Matrix(trainingBlock: trainingBlock),
        );
      },
    );
  }
}

class Matrix extends ConsumerStatefulWidget {
  final TrainingBlockClient trainingBlock;

  const Matrix({super.key, required this.trainingBlock});

  @override
  ConsumerState<Matrix> createState() => _MatrixState();
}

class _MatrixState extends ConsumerState<Matrix> {
  late ScrollController _verticalScrollController;
  late LinkedScrollControllerGroup _horizontalScrollControllersGroup;
  final Map<String, ScrollController> _horizontalScrollControllersMap = {};
  double _horizontalScrollOffset = 0;
  bool showArchived = false;

  @override
  void initState() {
    super.initState();

    _horizontalScrollControllersGroup = LinkedScrollControllerGroup()
      ..addOffsetChangedListener(() {
        _horizontalScrollOffset = _horizontalScrollControllersGroup.offset;
      });

    // this is needed to reset the horizontal scroll offset for the lists that have been
    // scrolled out of the viewport and became de-synchronized with the currently-visible
    // horizontal lists
    _verticalScrollController = ScrollController()
      ..addListener(() {
        _horizontalScrollControllersGroup.jumpTo(_horizontalScrollOffset);
      });

    for (final pseudoId in _nonEmptyDayPseudoIds) {
      _horizontalScrollControllersMap[pseudoId] = _horizontalScrollControllersGroup.addAndGet();
    }
  }

  @override
  void didUpdateWidget(Matrix oldWidget) {
    super.didUpdateWidget(oldWidget);

    final setOfNonEmptyDayPseudoIds = _nonEmptyDayPseudoIds;
    final setOfScrollAttachedDayPseudoIds = _horizontalScrollControllersMap.keys.toSet();

    if (setEquals(setOfNonEmptyDayPseudoIds, setOfScrollAttachedDayPseudoIds)) return;

    // remove controllers that are no longer needed (for example, if an exercise day was archived)
    for (final pseudoId in setOfScrollAttachedDayPseudoIds.difference(setOfNonEmptyDayPseudoIds)) {
      _horizontalScrollControllersMap[pseudoId]!.dispose();
      _horizontalScrollControllersMap.remove(pseudoId);
    }

    // add controllers for new exercise days
    for (final pseudoId in setOfNonEmptyDayPseudoIds.difference(setOfScrollAttachedDayPseudoIds)) {
      _horizontalScrollControllersMap[pseudoId] = _horizontalScrollControllersGroup.addAndGet();
    }
  }

  // we only want to attach scroll controllers to the non-empty exercise days, because
  // otherwise the other scroll controllers are "reset" to the 0 position when the
  // empty exercise day is scrolled into view, because it doesn't have any horizontal size
  Set<String> get _nonEmptyDayPseudoIds => widget.trainingBlock.exerciseDays
      //
      .where((e) => e.exerciseTypes.isNotEmpty)
      .map((e) => e.dbModel.pseudoId)
      .toSet();

  @override
  void dispose() {
    for (final controller in _horizontalScrollControllersMap.values) {
      controller.dispose();
    }

    _verticalScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final compactModeSwitcher = ref.watch(compactModeSwitcherProvider.notifier);
    final exerciseReactionsSwitcher = ref.watch(exerciseReactionsSwitcherProvider.notifier);
    final editModeSwitcher = ref.watch(editModeSwitcherProvider.notifier);
    final isTimerEnabledSwitcher = ref.watch(timerSwitcherProvider.notifier);

    final isCompactMode = ref.watch(compactModeSwitcherProvider);
    final isExerciseReactionsEnabled = ref.watch(exerciseReactionsSwitcherProvider);
    final isEditMode = ref.watch(editModeSwitcherProvider);
    final isTimerEnabled = ref.watch(timerSwitcherProvider);

    final menuItemTheme = Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        );

    return CustomScrollView(
      controller: _verticalScrollController,
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 152,
          backgroundColor: Theme.of(context).colorScheme.background,
          shadowColor: Colors.transparent,
          centerTitle: false,
          pinned: true,
          leading: GoBackButton(onPressed: () => context.pop()),
          flexibleSpace: CustomFlexibleSpaceBar(
            centerTitle: false,
            title: AnimatedContainer(
              width: 200,
              duration: WidgetParams.animationDuration,
              curve: WidgetParams.animationCurve,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(isEditMode ? 1.0 : 0.0),
                    width: 1,
                  ),
                ),
              ),
              child: GestureDetector(
                onTap: isEditMode
                    ? () => context.pushNamed(
                          RouteNames.trainingBlockCreateUpdate,
                          extra: Tuple2(widget.trainingBlock, false),
                        )
                    : null,
                child: AutoSizeText(
                  widget.trainingBlock.name,
                  softWrap: false,
                  maxLines: 1,
                  minFontSize: ((Theme.of(context).textTheme.titleLarge?.fontSize ?? 1) * 0.9).roundToDouble(),
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
            ),
          ),
          actions: [
            AnimatedOpacity(
              opacity: isEditMode ? 0 : 1,
              duration: WidgetParams.animationDuration,
              curve: WidgetParams.animationCurve,
              child: IconButton(
                icon: Icon(Icons.add, color: Theme.of(context).colorScheme.onSurface),
                tooltip: 'Add new entry',
                splashRadius: 20,
                onPressed: isEditMode
                    ? null
                    : () => context.pushNamed(
                          RouteNames.exerciseDayCreateUpdate,
                          extra: Tuple2(widget.trainingBlock.dbModel.id, null),
                        ),
              ),
            ),
            AnimatedOpacity(
              opacity: isEditMode ? 0 : 1,
              duration: WidgetParams.animationDuration,
              curve: WidgetParams.animationCurve,
              child: IconButton(
                icon: Icon(Icons.edit_outlined, color: Theme.of(context).colorScheme.onSurface),
                tooltip: 'Turn on edit mode',
                splashRadius: 20,
                onPressed: () => isEditMode ? null : editModeSwitcher.toggle(),
              ),
            ),
            AnimatedCrossFade(
              alignment: Alignment.center,
              crossFadeState: isEditMode ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: WidgetParams.animationDuration,
              firstCurve: WidgetParams.animationCurve,
              secondCurve: WidgetParams.animationCurve,
              firstChild: ButtonDropdownMenu(
                icon: Icons.more_vert,
                animationDuration: WidgetParams.animationDuration,
                animationCurve: WidgetParams.animationCurve,
                items: [
                  ButtonDropdownMenuItem(
                    onTap: () => context.push('/settings'),
                    child: Text('Settings', style: menuItemTheme),
                  ),
                  ButtonDropdownMenuItem(
                    onTap: compactModeSwitcher.toggle,
                    child: OnOffText(
                      title: 'Compact mode',
                      isEnabled: isCompactMode,
                      textStyle: menuItemTheme,
                    ),
                  ),
                  ButtonDropdownMenuItem(
                    onTap: exerciseReactionsSwitcher.toggle,
                    child: OnOffText(
                      title: 'Ex. Reactions',
                      isEnabled: isExerciseReactionsEnabled,
                      textStyle: menuItemTheme,
                    ),
                  ),
                  ButtonDropdownMenuItem(
                    onTap: isTimerEnabledSwitcher.toggle,
                    child: OnOffText(
                      title: 'Timer',
                      isEnabled: isTimerEnabled,
                      textStyle: menuItemTheme,
                    ),
                  ),
                ],
              ),
              secondChild: Row(
                children: [
                  Text(
                    'Archived',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  const SizedBox(width: 8),
                  Switch(
                    value: showArchived,
                    onChanged: (bool value) {
                      setState(() {
                        showArchived = value;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.check, color: Theme.of(context).colorScheme.primary),
                    tooltip: 'Turn off edit mode',
                    splashRadius: 20,
                    onPressed: () => editModeSwitcher.toggle(),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (widget.trainingBlock.exerciseDays.isNotEmpty) const SliverPadding(padding: EdgeInsets.only(top: 24)),
        widget.trainingBlock.exerciseDays.isEmpty
            ? const SliverToBoxAdapter(child: Center(child: EmptyPagePlaceholder()))
            : SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: widget.trainingBlock.exerciseDays.length,
                  (BuildContext context, int i) {
                    final exerciseDay = widget.trainingBlock.exerciseDays[i];

                    return Stack(
                      // this key is needed in order for the archival of the exercise
                      // days to work properly and for the list not to become "confused"
                      // by its items being removed
                      key: ValueKey(exerciseDay.dbModel.pseudoId),
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: HorizontallyScrollableExercises(
                            scrollController: _horizontalScrollControllersMap[exerciseDay.dbModel.pseudoId],
                            trainingBlock: widget.trainingBlock,
                            exerciseDay: exerciseDay,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: HorizontallyScrollableExerciseLabels(
                            exerciseDay: exerciseDay,
                            trainingBlock: widget.trainingBlock,
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
      ],
    );
  }
}

class OnOffText extends StatelessWidget {
  final String title;
  final bool isEnabled;
  final TextStyle? textStyle;

  const OnOffText({
    super.key,
    required this.title,
    required this.isEnabled,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final menuItemSubTextTheme = Theme.of(context).textTheme.labelSmall?.copyWith(
          color: isEnabled ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface,
        );

    return RichText(
      softWrap: false,
      text: TextSpan(
        text: title,
        style: textStyle,
        children: [
          WidgetSpan(
            child: Container(
              margin: const EdgeInsets.only(left: 24.0),
              padding: const EdgeInsets.only(bottom: 1.0),
              child: Text(isEnabled ? 'On' : 'Off', style: menuItemSubTextTheme),
            ),
          ),
        ],
      ),
    );
  }
}
