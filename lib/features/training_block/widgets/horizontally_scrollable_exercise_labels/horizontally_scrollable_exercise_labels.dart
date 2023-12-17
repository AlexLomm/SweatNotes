import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sweatnotes/router/router.dart';
import 'package:tuple/tuple.dart';

import '../../../../app.dart';
import '../../../../widgets/custom_bottom_sheet/custom_bottom_sheet.dart';
import '../../../../widgets/custom_dismissible.dart';
import '../../../../widgets/rounded_icon_button.dart';
import '../../../../widgets/text_editor_single_line_and_wheel.dart';
import '../../../settings/edit_mode_switcher.dart';
import '../../../settings/show_archived_exercise_types_switcher.dart';
import '../../data/models_client/exercise_day_client.dart';
import '../../data/models_client/training_block_client.dart';
import '../../services/exercise_types_service.dart';
import '../../services/training_blocks_service.dart';
import '../../widget_params.dart';
import '../ignore_pointer_edit_mode.dart';
import 'exercise_day_widget.dart';
import 'exercise_types_list.dart';

class HorizontallyScrollableExerciseLabels extends ConsumerStatefulWidget {
  final ExerciseDayClient exerciseDay;
  final TrainingBlockClient trainingBlock;

  const HorizontallyScrollableExerciseLabels({
    super.key,
    required this.exerciseDay,
    // TODO: provide via riverpod?
    required this.trainingBlock,
  });

  @override
  ConsumerState createState() => _HorizontallyScrollableExerciseLabelsState();
}

class _HorizontallyScrollableExerciseLabelsState extends ConsumerState<HorizontallyScrollableExerciseLabels> {
  double _dismissProgress = 0;

  @override
  Widget build(BuildContext context) {
    ref.listen(editModeSwitcherProvider, (_, isEditMode) {
      if (!isEditMode) setState(() => _dismissProgress = 0);
    });

    final messenger = ref.watch(messengerProvider);
    final trainingBlocksService = ref.watch(trainingBlocksServiceProvider);
    final widgetParams = ref.watch(widgetParamsProvider);
    final isEditMode = ref.watch(editModeSwitcherProvider);
    final showArchived = ref.watch(showArchivedExerciseTypesSwitcherProvider);

    final count = widget.exerciseDay.exerciseTypes.where((et) => showArchived ? true : et.archivedAt == null).length;

    final heightWithButton = widgetParams.getExerciseLabelsHeightWithButton(count);
    final heightWithoutButton = widgetParams.getExerciseLabelsHeight(count);

    return Container(
      margin: EdgeInsets.only(
        bottom: widgetParams.exercisesMarginBottom,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: AnimatedContainer(
              duration: WidgetParams.animationDuration,
              curve: WidgetParams.animationCurve,
              width: widgetParams.exerciseLabelsListWidth,
              height: heightWithButton,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: _Background(
                      id: widget.exerciseDay.dbModel.pseudoId,
                      width: widgetParams.exerciseLabelsListWidth,
                      height: heightWithoutButton,
                      borderRadius: widgetParams.borderRadius,
                      onUpdate: (details) => setState(() => _dismissProgress = details.progress),
                      onDismissed: (_) {
                        trainingBlocksService.archiveExerciseDay(
                          trainingBlock: widget.trainingBlock,
                          exerciseDay: widget.exerciseDay,
                          archive: true,
                        );

                        messenger?.clearSnackBars();
                        messenger?.showSnackBar(
                          SnackBar(
                            content: Text('Exercise day "${widget.exerciseDay.name}" archived'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () => trainingBlocksService.archiveExerciseDay(
                                trainingBlock: widget.trainingBlock,
                                exerciseDay: widget.exerciseDay,
                                archive: false,
                              ),
                            ),
                          ),
                        );
                      },
                      child: IgnorePointerInEditMode(
                        onTap: () => context.pushNamed(
                          RouteNames.exerciseDayCreateUpdate,
                          extra: Tuple2(widget.trainingBlock.dbModel.id, widget.exerciseDay),
                        ),
                        child: ExerciseDayWidget(
                          exerciseDay: widget.exerciseDay,
                          trainingBlock: widget.trainingBlock,
                        ),
                      ),
                    ),
                  ),
                  // using Align instead of Positioned or transform, because the
                  // rounded button can't be Transform.translate()'d, as the
                  // button won't be registering taps in that case
                  // @see https://stackoverflow.com/a/62500610/4241959
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedOpacity(
                      opacity: isEditMode ? 0.0 : 1.0,
                      duration: WidgetParams.animationDuration,
                      curve: WidgetParams.animationCurve,
                      child: RoundedIconButton(
                        size: widgetParams.addExerciseButtonSize,
                        onPressed: isEditMode
                            ? null
                            : () => CustomBottomSheet(
                                  height: CustomBottomSheet.allSpacing + TextEditorSingleLineAndWheel.height,
                                  title: 'Add exercise type',
                                  child: _TextEditorSingleLineAndWheelWrapper(
                                    trainingBlock: widget.trainingBlock,
                                    exerciseDay: widget.exerciseDay,
                                  ),
                                ).show(context),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Opacity(
              opacity: (1.0 - _dismissProgress).clamp(0, 1),
              child: ExerciseTypesList(
                trainingBlock: widget.trainingBlock,
                exerciseDay: widget.exerciseDay,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Background extends ConsumerWidget {
  final String id;
  final double height;
  final double width;
  final Widget child;
  final double borderRadius;
  final DismissUpdateCallback onUpdate;
  final DismissDirectionCallback onDismissed;

  const _Background({
    required this.id,
    required this.height,
    required this.width,
    required this.child,
    required this.borderRadius,
    required this.onUpdate,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref.watch(editModeSwitcherProvider);

    return AnimatedContainer(
      duration: WidgetParams.animationDuration,
      curve: WidgetParams.animationCurve,
      height: height,
      width: width,
      child: Material(
        elevation: 2,
        surfaceTintColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(borderRadius),
            bottomRight: Radius.circular(borderRadius),
          ),
        ),
        child: CustomDismissible(
          id: id,
          isEnabled: isEditMode,
          onUpdate: onUpdate,
          onDismissed: onDismissed,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(borderRadius),
            bottomRight: Radius.circular(borderRadius),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _TextEditorSingleLineAndWheelWrapper extends ConsumerWidget {
  final TrainingBlockClient trainingBlock;
  final ExerciseDayClient exerciseDay;

  const _TextEditorSingleLineAndWheelWrapper({
    required this.trainingBlock,
    required this.exerciseDay,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exerciseTypesService = ref.watch(exerciseTypesServiceProvider);

    return TextEditorSingleLineAndWheel(
      value: '',
      // TODO: replace with user preferred value
      unit: 'lb',
      buttonLabel: 'Add',
      hintText: 'Enter name',
      options: const ['lb', 'kg'],
      onSubmitted: (String name, String unit) {
        exerciseTypesService.create(
          trainingBlock: trainingBlock,
          exerciseDay: exerciseDay,
          name: name,
          unit: unit,
        );

        Navigator.of(context).pop();
      },
    );
  }
}
