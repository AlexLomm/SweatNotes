import 'package:flutter/material.dart';

// Shared
const animationDuration = Duration(milliseconds: 300);
const animationCurve = Cubic(0.79, 0.14, 0.15, 0.86);
const borderRadius = 8.0;

// Exercise type
const etHeight = 80.0;

const etWidth = 128.0;
const etDragHandleWidth = 0.0;
const etDropdownWidth = 0.0;
const etPaddingLeft = 8.0;
const etLabelWidth = etWidth - etDragHandleWidth - etPaddingLeft;

const etWidthExpanded = 216.0;
const etDragHandleWidthExpanded = 48.0;
const etDropdownWidthExpanded = 48.0;
const etPaddingLeftExpanded = 0.0;
const etLabelWidthExpanded =
    etWidthExpanded - etDragHandleWidthExpanded - etDropdownWidthExpanded - etPaddingLeftExpanded;

// Exercise labels scroll container
const elscRightInsetSize = 18.0;
const elscWidth = etWidth - elscRightInsetSize;
const elscTitleHeight = 56.0;
const elscSpacingBetweenItems = 8.0;
const elscAdditionalBottomSpaceHeight = 28.0 - elscSpacingBetweenItems;
const elscAddExerciseTypeButtonSize = 40.0;
const elscSpaceForExerciseTypeButton = elscAddExerciseTypeButtonSize / 2;
const elscMarginBottom = 44.0;

const elscWidthExpanded = etWidthExpanded - elscRightInsetSize;

// Exercises scroll container
const escInwardsDepth = 16.0;
const escMarginTop = elscTitleHeight;
const escMarginLeft = etWidth - escInwardsDepth + 8.0;

const escMarginBottomNotLast = elscSpacingBetweenItems;
const escMarginBottomLast = escMarginBottomNotLast +
    elscTitleHeight +
    elscAdditionalBottomSpaceHeight +
    elscSpaceForExerciseTypeButton +
    elscMarginBottom;

// Exercise set
const exerciseSetWidth = 64.0;
