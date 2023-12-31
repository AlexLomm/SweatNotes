import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../constants/enums.dart';
import '../core/tutor_controller.dart';

part 'tutor_tooltip_model.freezed.dart';

@freezed
class TutorTooltipModel with _$TutorTooltipModel {
  const TutorTooltipModel._();

  factory TutorTooltipModel({
    required final GlobalKey widgetKey,
    required final bool active,
    Function()? onClose,
    @Default(false) final bool absorbPointer,
    required final Widget Function(TutorController) buildChild,
    required final Widget Function(TutorController, Size) buildTooltip,
    @Default(TooltipPosition.bottom)
    final TooltipPosition position,
    @Default(TooltipAnchor.withWidget)
    final TooltipAnchor anchor,
    required final int order,
  }) = _TutorTooltipModel;
}
