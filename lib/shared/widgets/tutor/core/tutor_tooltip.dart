import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constants/enums.dart';
import '../model/tutor_tooltip_model.dart';
import 'tutor_controller.dart';
import 'tutor_scaffold.dart';

class TutorTooltip extends StatefulWidget {
  final bool active;
  final void Function(TutorController)? onTap;
  final void Function()? onClose;
  final bool absorbPointer;
  final int order;
  final Widget Function(TutorController) buildChild;
  final Widget Function(TutorController, Rect?) buildTooltip;
  final TooltipVerticalPosition tooltipVerticalPosition;
  final TooltipHorizontalPosition tooltipHorizontalPosition;

  const TutorTooltip({
    super.key,
    required this.active,
    this.onTap,
    this.onClose,
    this.absorbPointer = true,
    required this.order,
    required this.buildChild,
    required this.buildTooltip,
    this.tooltipVerticalPosition = TooltipVerticalPosition.bottom,
    this.tooltipHorizontalPosition = TooltipHorizontalPosition.withWidget,
  });

  @override
  State<TutorTooltip> createState() => _TutorTooltipState();
}

class _TutorTooltipState extends State<TutorTooltip> {
  final GlobalKey widgetKey = GlobalKey();

  late TutorTooltipModel _model;

  @override
  void didUpdateWidget(TutorTooltip oldWidget) {
    if (oldWidget.active != widget.active) {
      _registerWidget();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    _registerWidget();
  }

  @override
  void dispose() {
    _unRegisterWidget();
    super.dispose();
  }

  void _registerWidget() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _model = TutorTooltipModel(
        widgetKey: widgetKey,
        active: widget.active,
        onClose: widget.onClose,
        absorbPointer: widget.absorbPointer,
        buildChild: widget.buildChild,
        buildTooltip: widget.buildTooltip,
        verticalPosition: widget.tooltipVerticalPosition,
        horizontalPosition: widget.tooltipHorizontalPosition,
        order: widget.order,
      );

      try {
        TutorScaffold.of(context).register(_model);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    });
  }

  void _unRegisterWidget() {
    TutorScaffold.of(context).unregister(_model);
  }

  @override
  Widget build(BuildContext context) {
    final controller = TutorScaffold.of(context).controller;

    return Material(
      key: widgetKey,
      color: Colors.transparent,
      child: Builder(
        builder: (BuildContext context) => widget.buildChild(controller),
      ),
    );
  }
}
