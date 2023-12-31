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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final provider = TutorControllerProvider.of(context);

    if (provider == null) return;

    if (_controller != provider.controller) {
      _controller?.dispose();
      _controller = provider.controller;
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    if (controller == null) return Container();

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

class _TutorLayout extends StatefulWidget {
  final TutorTooltipModel model;
  final TutorController controller;

  const _TutorLayout({
    super.key,
    required this.model,
    required this.controller,
  });

  @override
  State<_TutorLayout> createState() => _TutorLayoutState();
}

class _TutorLayoutState extends State<_TutorLayout> {
  Size childSize = Size.zero;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      final globalPaintBounds = widget.model.widgetKey.globalPaintBounds!;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        final newSize = widget.model.widgetKey.currentContext?.size;

        if (newSize == null || newSize == childSize) return;

        setState(() => childSize = newSize);
      });

      if (childSize == Size.zero) {
        return const SizedBox.shrink();
      }

      final childPosition = Rect.fromLTRB(
        globalPaintBounds.left,
        globalPaintBounds.top,
        size.maxWidth - globalPaintBounds.right,
        size.maxHeight - globalPaintBounds.bottom,
      );

      final tooltip = widget.model.buildTooltip(
        widget.controller,
        childSize,
      );

      return Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: childPosition.top,
            left: childPosition.left,
            bottom: childPosition.bottom,
            right: childPosition.right,
            child: GestureDetector(
              onTap: widget.controller.next,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: childSize.width,
                  height: childSize.height,
                  child: AbsorbPointer(
                    absorbing: widget.model.absorbPointer,
                    child: widget.model.buildChild(widget.controller),
                  ),
                ),
              ),
            ),
          ),
          if (widget.model.position == TooltipPosition.top)
            Positioned(
              left: childPosition.left,
              bottom: childPosition.bottom + childSize.height,
              child: tooltip,
            ),
          if (widget.model.position == TooltipPosition.bottom)
            Positioned(
              left: childPosition.left,
              top: childPosition.top + childSize.height,
              child: tooltip,
            ),
          if (widget.model.position == TooltipPosition.left)
            Positioned(
              right: childPosition.right + childSize.width,
              top: childPosition.top,
              child: tooltip,
            ),
          if (widget.model.position == TooltipPosition.right)
            Positioned(
              left: childPosition.left + childSize.width,
              top: childPosition.top,
              child: tooltip,
            ),
        ],
      );
    });
  }
}
