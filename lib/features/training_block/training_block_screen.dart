import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import '../../features/training_block/services/exercise_days_service.dart';
import '../../router/router.dart';
import '../../shared_preferences.dart';
import '../../widgets/custom_bottom_sheet/custom_bottom_sheet.dart';
import '../../widgets/empty_page_placeholder.dart';
import '../../widgets/layout.dart';
import '../../widgets/text_editor_single_line.dart';
import 'data/models_client/exercise_day_client.dart';
import 'exercise_day_widget.dart';
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
  late final Stream<List<ExerciseDayClient>> exerciseDaysStream;
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

    prefs.setString('initialLocation', '/');
  }

  @override
  void initState() {
    super.initState();

    final normalizeDataService = ref.read(normalizeDataServiceProvider(
      widget.trainingBlockId,
    ));

    exerciseDaysStream = normalizeDataService.exerciseDays;
  }

  @override
  Widget build(BuildContext context) {
    final exerciseDaysService = ref.watch(exerciseDaysServiceProvider);

    return Layout(
      isScrollable: false,
      onGoBackButtonTap: () => context.go('/'),
      actions: [
        IconButton(
          icon: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          tooltip: 'Add new entry',
          splashRadius: 20,
          onPressed: () => CustomBottomSheet(
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
        IconButton(
          icon: Icon(
            Icons.edit_outlined,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          tooltip: 'Turn on edit mode',
          splashRadius: 20,
          onPressed: () {},
        ),
      ],
      child: StreamBuilder(
        stream: exerciseDaysStream,
        builder: (context, snapshot) {
          final exerciseDays = snapshot.data;

          if (exerciseDays == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (exerciseDays.isEmpty) {
            return const Center(child: EmptyPagePlaceholder());
          }

          return Matrix(exerciseDays: exerciseDays);
        },
      ),
    );
  }
}

class Matrix extends StatefulWidget {
  final List<ExerciseDayClient> exerciseDays;

  const Matrix({Key? key, required this.exerciseDays}) : super(key: key);

  @override
  State<Matrix> createState() => _MatrixState();
}

class _MatrixState extends State<Matrix> {
  final _controllerGroup = LinkedScrollControllerGroup();
  final Map<String, ScrollController> _controllersMap = {};

  @override
  void initState() {
    super.initState();

    for (final exerciseDay in widget.exerciseDays) {
      if (exerciseDay.exerciseTypes.isEmpty) continue;

      setState(() => _controllersMap[exerciseDay.id] = _controllerGroup.addAndGet());
    }
  }

  @override
  void didUpdateWidget(Matrix oldWidget) {
    super.didUpdateWidget(oldWidget);

    for (final exerciseDay in widget.exerciseDays) {
      if (exerciseDay.exerciseTypes.isEmpty) continue;

      if (_controllersMap.containsKey(exerciseDay.id)) continue;

      setState(() => _controllersMap[exerciseDay.id] = _controllerGroup.addAndGet());
    }
  }

  @override
  void dispose() {
    for (final controller in _controllersMap.values) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: widget.exerciseDays.length,
          (BuildContext context, int i) {
            final exerciseDay = widget.exerciseDays[i];

            return Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: HorizontallyScrollableExercises(
                    // this is needed due to "If you add controllers dynamically, the corresponding scrollables
                    // must be given unique keys to avoid the scroll offset going out of sync."
                    // @see https://pub.dev/packages/linked_scroll_controller
                    key: ValueKey(exerciseDay.id),
                    controller: _controllersMap[exerciseDay.id],
                    exerciseDay: exerciseDay,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: ExerciseDayWidget(
                    exerciseDay: exerciseDay,
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
