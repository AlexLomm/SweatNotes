import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/ribbon.dart';
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
              isPersonalRecord: exerciseSet.isPersonalRecord,
              child: _RepsText(
                exerciseSet: exerciseSet,
                textColor: textColor,
                labelSmallTheme: labelSmallTheme,
                labelLargeTheme: labelLargeTheme,
              ),
            ),
            _Cell(
              isBottomCell: true,
              isSingle: isSingle,
              isRightmost: isRightmost,
              exerciseSet: exerciseSet,
              child: _LoadText(
                exerciseSet: exerciseSet,
                textColor: textColor,
                labelSmallTheme: labelSmallTheme,
                labelLargeTheme: labelLargeTheme,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RepsText extends StatelessWidget {
  final ExerciseSetClient exerciseSet;
  final Color textColor;
  final TextStyle labelSmallTheme;
  final TextStyle labelLargeTheme;

  bool get _shouldShowPredictedReps => exerciseSet.reps == 0;

  const _RepsText({
    Key? key,
    required this.exerciseSet,
    required this.textColor,
    required this.labelSmallTheme,
    required this.labelLargeTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reps = _shouldShowPredictedReps ? exerciseSet.predictedReps : exerciseSet.reps;
    final color = _shouldShowPredictedReps ? textColor.withOpacity(0.32) : textColor;

    return AutoSizeText(
      '$reps',
      maxLines: 1,
      minFontSize: labelSmallTheme.fontSize!,
      style: labelLargeTheme.copyWith(color: color),
    );
  }
}

class _LoadText extends ConsumerWidget {
  final ExerciseSetClient exerciseSet;
  final Color textColor;
  final TextStyle labelSmallTheme;
  final TextStyle labelLargeTheme;

  bool get _shouldShowPredictedLoad => exerciseSet.load == 0;

  const _LoadText({
    Key? key,
    required this.exerciseSet,
    required this.textColor,
    required this.labelSmallTheme,
    required this.labelLargeTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCompactMode = ref.watch(widgetParamsProvider).isCompactMode;
    final load = _shouldShowPredictedLoad ? exerciseSet.predictedLoad : exerciseSet.load;
    final color = _shouldShowPredictedLoad ? textColor.withOpacity(0.32) : textColor;

    const maxLines = 1;
    final minFontSize = labelSmallTheme.fontSize!;
    final labelLargeStyle = labelLargeTheme.copyWith(color: color);
    final labelSmallStyle = labelSmallTheme.copyWith(color: color);

    return isCompactMode
        ? Stack(children: [
            Align(
              alignment: Alignment.topCenter,
              child: AutoSizeText(
                '$load',
                maxLines: maxLines,
                minFontSize: minFontSize,
                style: labelLargeStyle,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AutoSizeText(exerciseSet.unit, style: labelSmallStyle),
            )
          ])
        : AutoSizeText.rich(
            TextSpan(
              text: '$load',
              children: [
                TextSpan(
                  text: load == 0 ? '' : ' ${exerciseSet.unit}',
                  style: labelSmallStyle,
                ),
              ],
            ),
            maxLines: maxLines,
            minFontSize: minFontSize,
            style: labelLargeStyle,
          );
  }
}

class _Cell extends ConsumerWidget {
  final bool isSingle;
  final bool isRightmost;
  final bool isBottomCell;
  final ExerciseSetClient exerciseSet;
  final Widget child;
  final bool isPersonalRecord;

  const _Cell({
    Key? key,
    required this.exerciseSet,
    required this.isSingle,
    required this.isRightmost,
    required this.isBottomCell,
    required this.child,
    this.isPersonalRecord = false,
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

    final container = Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: isBottomCell ? borderBottomCell : borderTopCell,
      ),
      height: widgetParams.exerciseTypeHeight / 2,
      child: Center(child: child),
    );

    final nearLength = widgetParams.isCompactMode ? 8.0 : 12.0;
    final farLength = widgetParams.isCompactMode ? 24.0 : 32.0;
    final fontSize = widgetParams.isCompactMode ? 9.0 : 10.0;

    return isPersonalRecord
        ? Ribbon(
            title: 'PR',
            nearLength: nearLength,
            farLength: farLength,
            color: Theme.of(context).colorScheme.primary,
            location: RibbonLocation.topEnd,
            titleStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                  fontSize: fontSize,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
            child: container,
          )
        : container;
  }
}
