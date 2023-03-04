import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models_client/exercise_set_client.dart';
import 'exercise_type_widget.dart';

class ExerciseSetWidget extends StatelessWidget {
  static const width = 75.0;
  static const borderRadius = Radius.circular(8);

  final bool isSingle;
  final bool isLeftmost;
  final bool isRightmost;
  final ExerciseSetClient exerciseSet;
  final VoidCallback? onTap;

  const ExerciseSetWidget({
    Key? key,
    this.isSingle = false,
    this.isLeftmost = false,
    this.isRightmost = false,
    required this.exerciseSet,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        Theme.of(context).colorScheme.surfaceVariant.withOpacity(
              kDebugMode && exerciseSet.isFiller ? 0.5 : 1,
            );

    final borderSide = BorderSide(
      color: Theme.of(context).colorScheme.outline.withOpacity(0.32),
      width: 1,
    );

    final borderTopCell = Border(
      right: isSingle || isRightmost ? BorderSide.none : borderSide,
      bottom: borderSide,
    );

    final borderBottomCell = Border(
      right: isSingle || isRightmost ? BorderSide.none : borderSide,
    );

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: ExerciseTypeWidget.height,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                border: borderTopCell,
              ),
              height: ExerciseTypeWidget.height / 2,
              child: Center(
                child: Text(
                  exerciseSet.reps,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                border: borderBottomCell,
              ),
              height: ExerciseTypeWidget.height / 2,
              child: Center(
                child: Text(
                  exerciseSet.load,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
