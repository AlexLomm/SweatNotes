import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:journal_flutter/widgets/go_back_button.dart';

import '../../features/training_block/services/exercise_days_service.dart';
import '../../router/router.dart';
import '../../shared_preferences.dart';
import '../../widgets/button_dropdown_menu.dart';
import '../../widgets/custom_bottom_sheet/custom_bottom_sheet.dart';
import '../../widgets/empty_page_placeholder.dart';
import '../../widgets/layout.dart';
import '../../widgets/text_editor_single_line.dart';
import '../auth/services/auth_service.dart';
import '../settings/compact_mode_switcher.dart';
import '../settings/edit_mode_switcher.dart';
import 'custom_flexible_space_bar.dart';
import 'data/models_client/training_block_client.dart';
import 'services/training_block_details_stream.dart';
import 'services/training_blocks_service.dart';
import 'widget_params.dart';
import 'widgets/horizontally_scrollable_exercise_labels/horizontally_scrollable_exercise_labels.dart';
import 'widgets/horizontally_scrollable_exercises.dart';

class TrainingBlockScreen extends ConsumerStatefulWidget {
  final String trainingBlockId;

  const TrainingBlockScreen({
    Key? key,
    required this.trainingBlockId,
  }) : super(key: key);

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
    final data = ref.watch(trainingBlockDetailsStreamProvider(widget.trainingBlockId));

    return data.when(
      error: (Object error, StackTrace stackTrace) {
        WidgetsBinding.instance.addPostFrameCallback((_) => authService.signOut());

        return Center(child: Text(error.toString()));
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (trainingBlock) {
        if (trainingBlock == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) => context.go('/'));

          return const Center(child: CircularProgressIndicator());
        }

        return Layout(
          isScrollable: false,
          isAppBarVisible: false,
          padding: EdgeInsets.zero,
          child: Matrix(trainingBlock: trainingBlock),
        );
      },
    );
  }
}

class Matrix extends ConsumerWidget {
  final TrainingBlockClient trainingBlock;

  const Matrix({Key? key, required this.trainingBlock}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trainingBlocksService = ref.watch(trainingBlocksServiceProvider);
    final exerciseDaysService = ref.watch(exerciseDaysServiceProvider);

    final compactModeSwitcher = ref.watch(compactModeSwitcherProvider.notifier);
    final editModeSwitcher = ref.watch(editModeSwitcherProvider.notifier);
    final isCompactMode = ref.watch(compactModeSwitcherProvider);
    final isEditMode = ref.watch(editModeSwitcherProvider);

    final menuItemTheme = Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        );
    final menuItemSubTextTheme = Theme.of(context).textTheme.labelSmall?.copyWith(
          color: isCompactMode ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface,
        );

    return CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        expandedHeight: 152,
        backgroundColor: Theme.of(context).colorScheme.background,
        shadowColor: Colors.transparent,
        centerTitle: false,
        pinned: true,
        leading: GoBackButton(onPressed: () => context.go('/')),
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
                  ? () => CustomBottomSheet(
                        height: CustomBottomSheet.allSpacing + TextEditorSingleLine.height,
                        title: 'Update training block',
                        child: TextEditorSingleLine(
                          value: trainingBlock.name,
                          onSubmitted: (String text) {
                            trainingBlocksService.updateName(trainingBlock, text);

                            Navigator.of(context).pop();
                          },
                        ),
                      ).show(context)
                  : null,
              child: AutoSizeText(
                trainingBlock.name,
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
                  : () => CustomBottomSheet(
                        height: CustomBottomSheet.allSpacing + TextEditorSingleLine.height,
                        title: 'Add exercise day',
                        child: TextEditorSingleLine(
                          value: '',
                          onSubmitted: (String text) {
                            exerciseDaysService.create(trainingBlock: trainingBlock, name: text);

                            Navigator.of(context).pop();
                          },
                        ),
                      ).show(context),
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
                  onTap: compactModeSwitcher.toggle,
                  child: RichText(
                    softWrap: false,
                    text: TextSpan(
                      text: 'Compact mode',
                      style: menuItemTheme,
                      children: [
                        WidgetSpan(
                          child: Container(
                            margin: const EdgeInsets.only(left: 24.0),
                            padding: const EdgeInsets.only(bottom: 1.0),
                            child: Text(isCompactMode ? 'On' : 'Off', style: menuItemSubTextTheme),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            secondChild: IconButton(
              icon: Icon(Icons.check, color: Theme.of(context).colorScheme.primary),
              tooltip: 'Turn off edit mode',
              splashRadius: 20,
              onPressed: () => editModeSwitcher.toggle(),
            ),
          ),
        ],
      ),
      if (trainingBlock.exerciseDays.isNotEmpty) const SliverPadding(padding: EdgeInsets.only(top: 24)),
      trainingBlock.exerciseDays.isEmpty
          ? const SliverToBoxAdapter(child: Center(child: EmptyPagePlaceholder()))
          : SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: trainingBlock.exerciseDays.length,
                (BuildContext context, int i) {
                  final exerciseDay = trainingBlock.exerciseDays[i];

                  return Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: HorizontallyScrollableExercises(
                          exerciseDay: exerciseDay,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: HorizontallyScrollableExerciseLabels(
                          exerciseDay: exerciseDay,
                          trainingBlock: trainingBlock,
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
    ]);
  }
}
