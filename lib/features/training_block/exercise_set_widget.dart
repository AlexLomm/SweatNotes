import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'data/models_client/exercise_set_client.dart';
import 'exercise_type_widget.dart';

class ExerciseSetWidget extends StatelessWidget {
  static const width = 75.0;
  static const borderRadius = Radius.circular(8);

  final bool isSingle;
  final bool isRightmost;
  final ExerciseSetClient exerciseSet;
  final VoidCallback? onTap;

  const ExerciseSetWidget({
    Key? key,
    this.isSingle = false,
    this.isRightmost = false,
    required this.exerciseSet,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurfaceVariant;
    final labelSmallTheme = Theme.of(context).textTheme.labelSmall!;
    final labelLargeTheme = Theme.of(context).textTheme.labelLarge!;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: ExerciseTypeWidget.height,
        child: Column(
          children: [
            _Cell(
              isBottomCell: false,
              isSingle: isSingle,
              isRightmost: isRightmost,
              exerciseSet: exerciseSet,
              child: AutoSizeText(
                exerciseSet.reps,
                maxLines: 1,
                minFontSize: labelSmallTheme.fontSize!,
                style: labelLargeTheme.copyWith(color: textColor),
              ),
            ),
            _Cell(
              isBottomCell: true,
              isSingle: isSingle,
              isRightmost: isRightmost,
              exerciseSet: exerciseSet,
              child: AutoSizeText.rich(
                TextSpan(
                  text: exerciseSet.load,
                  children: [
                    TextSpan(
                      text: ' ',
                      style: labelSmallTheme.copyWith(color: textColor),
                    ),
                    TextSpan(
                      text: exerciseSet.unit,
                      style: labelSmallTheme.copyWith(color: textColor),
                    ),
                  ],
                ),
                maxLines: 1,
                minFontSize: labelSmallTheme.fontSize!,
                style: labelLargeTheme.copyWith(color: textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  final bool isSingle;
  final bool isRightmost;
  final bool isBottomCell;
  final ExerciseSetClient exerciseSet;
  final Widget child;

  const _Cell({
    Key? key,
    required this.exerciseSet,
    required this.isSingle,
    required this.isRightmost,
    required this.isBottomCell,
    required this.child,
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

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: isBottomCell ? borderBottomCell : borderTopCell,
      ),
      height: ExerciseTypeWidget.height / 2,
      child: Center(child: child),
    );
  }
}
