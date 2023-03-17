import 'dart:math';

import 'package:flutter/material.dart';
import 'package:journal_flutter/features/settings/edit_mode_switcher.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../settings/compact_mode_switcher.dart';

part 'widget_params.g.dart';

class WidgetParams {
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Cubic animationCurve = Cubic(0.79, 0.14, 0.15, 0.86);
  static const double borderRadius = 8.0;

  final bool isEditMode;
  final bool isCompactMode;

  WidgetParams({
    required this.isEditMode,
    required this.isCompactMode,
  });

  double get exerciseTypeHeight => isCompactMode ? 64.0 : 80.0;

  double get exerciseTypeLabelWidth {
    return exerciseTypeWidth - 2 * exerciseTypeDragHandleWidth - exerciseTypePaddingLeft;
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

  double get exerciseSetWidth => isCompactMode ? 64.0 : 80.0;

  double get exerciseDayTitleHeight => 56.0;

  double get exerciseTypesVerticalSpacing => 8.0;

  double getExerciseTypesListHeight(int exerciseTypesCount) {
    return (exerciseTypeHeight) * exerciseTypesCount + exerciseTypesVerticalSpacing * (exerciseTypesCount - 1);
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

  double get exerciseLabelsListWidth => exerciseTypeWidth - _exerciseLabelsListRightInsetSize;

  double get _exerciseLabelsListRightInsetSize => 18.0;

  double get exerciseLabelsListPaddingLeft => 8.0;

  double get exerciseLabelsListPaddingRight => 4.0;

  double getExercisesHeight(int exerciseTypesCount) {
    final count = max(1, exerciseTypesCount);

    return count * (exerciseTypeHeight + exerciseTypesVerticalSpacing) +
        additionalBottomSpacing +
        _exercisesMarginBottomLast;
  }

  double get _exercisesMarginBottomLast {
    return exercisesMarginBottomNotLast +
        exerciseDayTitleHeight +
        additionalBottomSpacing +
        spaceForExerciseButton +
        exercisesMarginBottom;
  }

  double get exercisesTitleHeight => 56.0;

  double get exercisesTitlePaddingLeft => 8.0;

  double get exercisesTitlePaddingRight => 4.0;

  double get exercisesMarginBottom => 44.0;

  double get exercisesMarginLeft => exerciseTypeWidth - exercisesScrollInwardsDepth + 8.0;

  double get exercisesSideSpacing => isCompactMode ? 8.0 : 16.0;

  double get exercisesScrollInwardsDepth => 16.0;

  double get exercisesMarginBottomNotLast => exerciseTypesVerticalSpacing;
}

// TODO: extract out
@riverpod
WidgetParams widgetParams(WidgetParamsRef ref) {
  final isEditMode = ref.watch(editModeSwitcherProvider);
  final isCompactMode = ref.watch(compactModeSwitcherProvider);

  return WidgetParams(isEditMode: isEditMode, isCompactMode: isCompactMode);
}
