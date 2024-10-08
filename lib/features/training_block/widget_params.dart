import 'dart:math';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../settings/compact_mode_switcher.dart';
import '../settings/edit_mode_switcher.dart';

part 'widget_params.g.dart';

class WidgetParams {
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Cubic animationCurve = Cubic(0.79, 0.14, 0.15, 0.86);

  static const Duration tutorialBackdropAnimationDuration =
      Duration(milliseconds: 1200);
  static const Duration tutorialTooltipAnimationDuration =
      Duration(milliseconds: 400);
  static const Duration tutorialTooltipAnimationDelayDuration =
      Duration(milliseconds: 800);
  static const Curve tutorialAnimationCurve = Curves.easeInSine;

  final bool isEditMode;
  final bool isCompactMode;

  WidgetParams({
    required this.isEditMode,
    required this.isCompactMode,
  });

  double get reactionCircleSize => isCompactMode ? 28.0 : 32.0;

  double get borderRadius => isCompactMode ? 4.0 : 8.0;

  double get exerciseTypeHeight => isCompactMode ? 72.0 : 80.0;

  double get exerciseTypeLabelWidth {
    return exerciseTypeWidth -
        2 * exerciseTypeDragHandleWidth -
        exerciseTypePaddingLeft;
  }

  double get exerciseTypeWidth {
    if (isEditMode && isCompactMode) {
      return 192.0;
    } else if (!isEditMode && isCompactMode) {
      return 104.0;
    } else if (isEditMode && !isCompactMode) {
      return 216.0;
    }

    return 128.0;
  }

  double get exerciseTypePaddingLeft {
    if (isEditMode && isCompactMode) {
      return 0;
    } else if (!isEditMode && isCompactMode) {
      return 8.0;
    } else if (isEditMode && !isCompactMode) {
      return 0.0;
    }

    return 8.0;
  }

  double get exerciseTypeDragHandleWidth => isEditMode ? 48.0 : 0.0;

  double get exerciseSetWidth => isCompactMode ? 52.0 : 80.0;

  double get exerciseDayTitleHeight => 56.0;

  double get exerciseTypesVerticalSpacing => isCompactMode ? 4.0 : 8.0;

  double getExerciseTypesListHeight(int exerciseTypesCount) {
    if (exerciseTypesCount == 0) return 0;

    return (exerciseTypeHeight) * exerciseTypesCount +
        exerciseTypesVerticalSpacing * (exerciseTypesCount - 1);
  }

  double getExerciseLabelsHeightWithButton(int exerciseTypesCount) {
    // add enough space for the add exercise type button's half size to fit
    return getExerciseLabelsHeight(exerciseTypesCount) + spaceForExerciseButton;
  }

  double getExerciseLabelsHeight(int exerciseTypesCount) {
    final count = max(1, exerciseTypesCount);

    return exerciseDayTitleHeight +
        count * (exerciseTypeHeight + exerciseTypesVerticalSpacing) +
        additionalBottomSpacing;
  }

  double get additionalBottomSpacing => 28.0 - exerciseTypesVerticalSpacing;

  double get spaceForExerciseButton => addExerciseButtonSize / 2;

  double get addExerciseButtonSize => 40.0;

  double get exerciseLabelsTitleWidth {
    return exerciseLabelsListWidth -
        //
        exerciseLabelsListPaddingLeft -
        exerciseLabelsListPaddingRight -
        exerciseTypeDragHandleWidth;
  }

  double get exerciseLabelsListWidth =>
      exerciseTypeWidth - _exerciseLabelsListRightInsetSize;

  double get _exerciseLabelsListRightInsetSize => 18.0;

  double get exerciseLabelsListPaddingLeft => 8.0;

  double get exerciseLabelsListPaddingRight => 4.0;

  double getExercisesHeight(int exerciseTypesCount) {
    return getExerciseLabelsHeight(exerciseTypesCount) -
        additionalBottomSpacing;
  }

  double get _exercisesMarginBottomLast {
    return exercisesMarginBottomNotLast +
        exerciseDayTitleHeight +
        additionalBottomSpacing +
        spaceForExerciseButton +
        exercisesMarginBottom;
  }

  double get exercisesTitleHeight => 56.0;

  double get exercisesTitlePaddingLeft => isEditMode ? 0.0 : 8.0;

  double get exercisesTitlePaddingRight => 4.0;

  double get exercisesMarginBottom => 44.0;

  double get exercisesMarginLeft =>
      exerciseTypeWidth - exercisesScrollInwardsDepth + exercisesSideSpacing;

  double get exercisesSideSpacing => isCompactMode ? 4.0 : 8.0;

  double get exercisesScrollInwardsDepth =>
      _exerciseLabelsListRightInsetSize + exercisesSideSpacing + 8.0;

  double get exercisesMarginBottomNotLast => exerciseTypesVerticalSpacing;
}

@riverpod
WidgetParams widgetParams(WidgetParamsRef ref) {
  final isEditMode = ref.watch(editModeSwitcherProvider);
  final isCompactMode = ref.watch(compactModeSwitcherProvider);

  return WidgetParams(isEditMode: isEditMode, isCompactMode: isCompactMode);
}
