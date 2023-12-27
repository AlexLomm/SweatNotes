import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sweatnotes/shared/widgets/tutor/constants/extensions.dart';

import '../constants/enums.dart';
import '../model/tutor_tooltip_model.dart';
import 'tutor_controller.dart';

class TutorScaffold extends StatefulWidget {
  final TutorController controller;
  final Widget Function(BuildContext context) builder;
  final Color overlayColor;
  final Future<bool> Function(int instantiatedWidgetLength)? startWhen;
  final Duration tooltipAnimationDuration;
  final Curve tooltipAnimationCurve;
  final Widget? preferredOverlay;

  const TutorScaffold({
    super.key,
    required this.controller,
    required this.builder,
    this.overlayColor = Colors.black54,
    this.startWhen,
    this.tooltipAnimationDuration = const Duration(milliseconds: 500),
    this.tooltipAnimationCurve = Curves.decelerate,
    this.preferredOverlay,
  });

  static TutorScaffoldState of(BuildContext context) {
    final TutorScaffoldState? result =
        context.findAncestorStateOfType<TutorScaffoldState>();

    if (result != null) return result;

    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary(
        'OverlayTooltipScaffold.of() called with a context that does not contain a OverlayTooltipScaffold.',
      ),
      ErrorDescription(
        'No OverlayTooltipScaffold ancestor could be found starting from the context that was passed to OverlayTooltipScaffold.of(). '
        'This usually happens when the context provided is from the same StatefulWidget as that '
        'whose build function actually creates the OverlayTooltipScaffold widget being sought.',
      ),
      context.describeElement('The context used was'),
    ]);
  }

  @override
  State<TutorScaffold> createState() => TutorScaffoldState();
}

class TutorScaffoldState extends State<TutorScaffold> {
  TutorController get controller => widget.controller;

  void register(TutorTooltipModel model) {
    widget.controller.register(model);
  }

  void unregister(TutorTooltipModel model) {
    widget.controller.unregister(model);
  }

  @override
  void initState() {
    super.initState();

    controller.isReady.addListener(() {
      if (!controller.isReady.value) return;

      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => controller.next(),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(child: Builder(builder: widget.builder)),
          StreamBuilder<TutorTooltipModel?>(
            stream: widget.controller.widgetsPlayStream,
            builder: (context, snapshot) {
              final data = snapshot.data;

              if (data == null) {
                return const SizedBox.shrink();
              }

              if (data.widgetKey.globalPaintBounds == null) {
                return const SizedBox.shrink();
              }

              return Positioned.fill(
                child: Stack(
                  children: [
                    widget.preferredOverlay ??
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: widget.overlayColor,
                        ),
                    TweenAnimationBuilder(
                      key: ValueKey(data.order),
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: widget.tooltipAnimationDuration,
                      curve: widget.tooltipAnimationCurve,
                      builder: (_, double val, child) {
                        val = min(val, 1);
                        val = max(val, 0);

                        return Opacity(opacity: val, child: child);
                      },
                      child: _TutorLayout(
                        model: data,
                        controller: widget.controller,
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class _TutorLayout extends StatelessWidget {
  final TutorTooltipModel model;
  final TutorController controller;

  const _TutorLayout({
    super.key,
    required this.model,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      var topLeft = model.widgetKey.globalPaintBounds!.topLeft;
      var bottomRight = model.widgetKey.globalPaintBounds!.bottomRight;

      if (topLeft.dx < 0) {
        bottomRight = Offset(bottomRight.dx + (0 - topLeft.dx), bottomRight.dy);
        topLeft = Offset(0, topLeft.dy);
      }

      if (bottomRight.dx > size.maxWidth) {
        topLeft = Offset(
          topLeft.dx - (bottomRight.dx - size.maxWidth),
          topLeft.dy,
        );
        bottomRight = Offset(size.maxWidth, bottomRight.dy);
      }

      if (topLeft.dy < 0) {
        bottomRight = Offset(bottomRight.dx, bottomRight.dy + (0 - topLeft.dy));
        topLeft = Offset(topLeft.dx, 0);
      }

      if (bottomRight.dy > size.maxHeight) {
        topLeft = Offset(
          topLeft.dx,
          topLeft.dy - (bottomRight.dy - size.maxHeight),
        );
        bottomRight = Offset(bottomRight.dx, size.maxHeight);
      }

      return Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: topLeft.dy,
            left: topLeft.dx,
            bottom: size.maxHeight - bottomRight.dy,
            right: size.maxWidth - bottomRight.dx,
            child: GestureDetector(
              onTap: () => controller.next(),
              child: AbsorbPointer(
                absorbing: model.absorbPointer,
                child: model.buildChild(controller),
              ),
            ),
          ),
          _buildToolTip(topLeft, bottomRight, size)
        ],
      );
    });
  }

  Widget _buildToolTip(
    Offset topLeft,
    Offset bottomRight,
    BoxConstraints size,
  ) {
    bool isTop = model.verticalPosition == TooltipVerticalPosition.top;

    bool alignLeft = topLeft.dx <= (size.maxWidth - bottomRight.dx);

    final calculatedLeft = alignLeft ? topLeft.dx : null;
    final calculatedRight = alignLeft ? null : size.maxWidth - bottomRight.dx;
    final calculatedTop = isTop ? null : bottomRight.dy;
    final calculatedBottom = isTop ? (size.maxHeight - topLeft.dy) : null;

    if (model.horizontalPosition == TooltipHorizontalPosition.withWidget) {
      return Positioned(
        top: calculatedTop,
        left: calculatedLeft,
        right: calculatedRight,
        bottom: calculatedBottom,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            model.buildTooltip(
              controller,
              model.widgetKey.globalPaintBounds,
            ),
          ],
        ),
      );
    }

    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        model.buildTooltip(
          controller,
          model.widgetKey.globalPaintBounds,
        ),
      ],
    );

    return Positioned(
      top: calculatedTop,
      left: 0,
      right: 0,
      bottom: calculatedBottom,
      child: model.horizontalPosition == TooltipHorizontalPosition.center
          ? Center(child: child)
          : Align(
              alignment:
                  model.horizontalPosition == TooltipHorizontalPosition.right
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
              child: child,
            ),
    );
  }
}
