import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widget_params.dart';
import '../data/models_client/exercise_set_client.dart';

const progressColors = <int, Color>{
  -4: Color.fromRGBO(244, 71, 70, 0.32),
  -3: Color.fromRGBO(236, 100, 45, 0.32),
  -2: Color.fromRGBO(223, 125, 22, 0.32),
  -1: Color.fromRGBO(205, 147, 4, 0.32),
  0: Color.fromRGBO(184, 166, 21, 0.32),
  1: Color.fromRGBO(160, 183, 51, 0.32),
  2: Color.fromRGBO(134, 197, 84, 0.32),
  3: Color.fromRGBO(102, 210, 120, 0.32),
  4: Color.fromRGBO(56, 221, 158, 0.32),
};

class ExerciseSetWidget extends ConsumerWidget {
  final bool isSingle;
  final bool isRightmost;
  final ExerciseSetClient exerciseSet;
  final VoidCallback? onTap;

  bool get _shouldShowPredictedReps => exerciseSet.reps.isEmpty;

  bool get _shouldShowPredictedLoad => exerciseSet.load.isEmpty;

  const ExerciseSetWidget({
    Key? key,
    this.isSingle = false,
    this.isRightmost = false,
    required this.exerciseSet,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetParams = ref.watch(widgetParamsProvider);

    final textColor = Theme.of(context).colorScheme.onSurfaceVariant;
    final labelSmallTheme = Theme.of(context).textTheme.labelSmall!;
    final labelLargeTheme = Theme.of(context).textTheme.labelLarge!;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: widgetParams.exerciseSetWidth,
        height: widgetParams.exerciseTypeHeight,
        child: Column(
          children: [
            _Cell(
              isBottomCell: false,
              isSingle: isSingle,
              isRightmost: isRightmost,
              exerciseSet: exerciseSet,
              child: AutoSizeText(
                _shouldShowPredictedReps ? exerciseSet.predictedReps : exerciseSet.reps,
                maxLines: 1,
                minFontSize: labelSmallTheme.fontSize!,
                style: labelLargeTheme.copyWith(color: textColor.withOpacity(_shouldShowPredictedReps ? 0.32 : 1)),
              ),
            ),
            _Cell(
              isBottomCell: true,
              isSingle: isSingle,
              isRightmost: isRightmost,
              exerciseSet: exerciseSet,
              child: AutoSizeText.rich(
                TextSpan(
                  text: _shouldShowPredictedLoad ? exerciseSet.predictedLoad : exerciseSet.load,
                  children: [
                    TextSpan(
                      text: ' ',
                      style: labelSmallTheme.copyWith(color: textColor),
                    ),
                    TextSpan(
                      text: exerciseSet.load.isEmpty ? '' : exerciseSet.unit,
                      style: labelSmallTheme.copyWith(color: textColor),
                    ),
                  ],
                ),
                maxLines: 1,
                minFontSize: labelSmallTheme.fontSize!,
                style: labelLargeTheme.copyWith(color: textColor.withOpacity(_shouldShowPredictedLoad ? 0.32 : 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Cell extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetParams = ref.watch(widgetParamsProvider);

    final backgroundColor = progressColors[exerciseSet.progressFactor] ??
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
      height: widgetParams.exerciseTypeHeight / 2,
      child: Center(child: child),
    );
  }
}
