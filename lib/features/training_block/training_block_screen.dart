import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/training_block/services/exercise_days_service.dart';
import '../../router/router.dart';
import '../../shared_preferences.dart';
import '../../widgets/custom_bottom_sheet/custom_bottom_sheet.dart';
import '../../widgets/layout.dart';
import '../../widgets/text_editor_single_line.dart';
import '../settings/edit_mode_switcher.dart';
import 'constants.dart';
import 'data/models_client/training_block_client.dart';
import 'horizontally_scrollable_exercise_labels.dart';
import 'horizontally_scrollable_exercises.dart';
import 'services/normalize_data_service/normalize_data_service.dart';

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
  late final Stream<TrainingBlockClient?> trainingBlockStream;
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
  void initState() {
    super.initState();

    final normalizeDataService = ref.read(normalizeDataServiceProvider(widget.trainingBlockId));

    trainingBlockStream = normalizeDataService.trainingBlock;
  }

  @override
  Widget build(BuildContext context) {
    final exerciseDaysService = ref.watch(exerciseDaysServiceProvider);

    final editModeSwitcher = ref.watch(editModeSwitcherProvider.notifier);
    final isEditMode = ref.watch(editModeSwitcherProvider);

    return Layout(
      isScrollable: false,
      onGoBackButtonTap: () => context.go('/'),
      actions: [
        AnimatedOpacity(
          opacity: isEditMode ? 0 : 1,
          duration: animationDuration,
          curve: animationCurve,
          child: IconButton(
            icon: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.onSurface,
            ),
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
                          exerciseDaysService.create(
                            trainingBlockId: widget.trainingBlockId,
                            name: text,
                          );

                          Navigator.of(context).pop();
                        },
                      ),
                    ).show(context),
          ),
        ),
        AnimatedCrossFade(
          alignment: Alignment.center,
          crossFadeState: isEditMode ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: animationDuration,
          firstCurve: animationCurve,
          secondCurve: animationCurve,
          firstChild: IconButton(
            icon: Icon(
              Icons.edit_outlined,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            tooltip: 'Turn on edit mode',
            splashRadius: 20,
            onPressed: () => editModeSwitcher.toggle(),
          ),
          secondChild: IconButton(
            icon: Icon(
              Icons.check,
              color: Theme.of(context).colorScheme.primary,
            ),
            tooltip: 'Turn off edit mode',
            splashRadius: 20,
            onPressed: () => editModeSwitcher.toggle(),
          ),
        ),
      ],
      child: StreamBuilder(
        stream: trainingBlockStream,
        builder: (context, snapshot) {
          final trainingBlock = snapshot.data;

          if (trainingBlock == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Matrix(trainingBlock: trainingBlock);
        },
      ),
    );
  }
}

class Matrix extends StatefulWidget {
  final TrainingBlockClient trainingBlock;

  const Matrix({Key? key, required this.trainingBlock}) : super(key: key);

  @override
  State<Matrix> createState() => _MatrixState();
}

class _MatrixState extends State<Matrix> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: widget.trainingBlock.exerciseDays.length,
          (BuildContext context, int i) {
            final exerciseDay = widget.trainingBlock.exerciseDays[i];

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
                    trainingBlock: widget.trainingBlock,
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
