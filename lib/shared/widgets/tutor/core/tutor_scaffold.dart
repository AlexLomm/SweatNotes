import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sweatnotes/shared/widgets/tutor/constants/extensions.dart';

import '../constants/enums.dart';
import '../model/tutor_tooltip_model.dart';
import 'tutor_controller_provider.dart';
import 'tutor_controller.dart';

class TutorScaffold extends StatefulWidget {
  final Widget child;
  final Color backdropColor;
  final Duration tooltipAnimationDuration;
  final Duration tooltipDelay;
  final Curve tooltipAnimationCurve;
  final Widget Function(BuildContext context, TutorController controller)?
      buildBackdrop;

  const TutorScaffold({
    super.key,
    required this.child,
    required this.backdropColor,
    required this.tooltipAnimationDuration,
    required this.tooltipDelay,
    required this.tooltipAnimationCurve,
    required this.buildBackdrop,
  });

  @override
  State<TutorScaffold> createState() => _TutorScaffoldState();
}

class _TutorScaffoldState extends State<TutorScaffold> {
  Timer? timer;

  TutorController? _controller;

  get controller => _controller!;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_controller != TutorControllerProvider.of(context).controller) {
      _controller?.dispose();
      _controller = TutorControllerProvider.of(context).controller;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(child: widget.child),
          StreamBuilder<TutorTooltipModel?>(
            stream: controller.widgetsPlayStream,
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
                    if (widget.buildBackdrop == null)
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: widget.backdropColor,
                      )
                    else
                      Builder(
                        builder: (context) => widget.buildBackdrop!(
                          context,
                          controller,
                        ),
                      ),
                    TweenAnimationBuilder(
                      key: ValueKey(data.order),
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: widget.tooltipAnimationDuration,
                      curve: widget.tooltipAnimationCurve,
                      builder: (_, double val, child) {
                        return Opacity(
                          opacity: val.clamp(0, 1),
                          child: child,
                        );
                      },
                      // wrapping the sub-tree with a TutorControllerProvider is necessary to support nested TutorTooltips.
                      // The reason is that we don't want the spawned TutorTooltips to re-register themselves with the
                      // controller. Rather, we are "tricking" them into registering to an empty "shell" controller.
                      //
                      //  Root TutorControllerProvider
                      //     │
                      //     ├────  TutorTooltip (1)
                      //     │        SomeWidget
                      //     │          TutorTooltip (2)
                      //     │            AnotherWidget
                      //     │
                      //     │     ┌───────────────────────┐
                      //     ├──── │...                    │
                      //     │     │  SomeWidget           │     Attempts to
                      //           │    TutorTooltip (2) ◄─┼──── re-register
                      //           │      AnotherWidget    │
                      //           │                       │
                      //           └───────────────────────┘
                      //
                      child: TutorControllerProvider(
                        controller: TutorController(),
                        child: _TutorLayout(
                          model: data,
                          controller: controller,
                        ),
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
      final globalPaintBounds = model.widgetKey.globalPaintBounds!;

      var topLeft = globalPaintBounds.topLeft;
      var bottomRight = globalPaintBounds.bottomRight;

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
            top: globalPaintBounds.top,
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
