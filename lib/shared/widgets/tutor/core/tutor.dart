import 'package:flutter/material.dart';

import 'tutor_controller.dart';
import 'tutor_controller_provider.dart';
import 'tutor_scaffold.dart';

class Tutor extends StatefulWidget {
  final TutorController? controller;
  final Color? backdropColor;
  final Duration backdropAnimationDuration;
  final Duration tooltipDelay;
  final Curve backdropAnimationCurve;
  final Duration tooltipAnimationDuration;
  final Curve tooltipAnimationCurve;
  final Widget child;
  final Function(TutorController controller)? onBackdropTap;
  final Widget Function(
    BuildContext context,
    TutorController controller,
  )? buildBackdrop;

  const Tutor({
    super.key,
    this.controller,
    this.backdropColor,
    this.backdropAnimationDuration = const Duration(milliseconds: 1200),
    // TODO: change back
    this.tooltipDelay = const Duration(milliseconds: 800),
    this.backdropAnimationCurve = Curves.easeInSine,
    this.tooltipAnimationDuration = const Duration(milliseconds: 400),
    this.tooltipAnimationCurve = Curves.easeInSine,
    required this.child,
    this.onBackdropTap,
    this.buildBackdrop,
  });

  @override
  State<Tutor> createState() => _TutorState();
}

class _TutorState extends State<Tutor> {
  final TutorController _defaultController = TutorController();

  @override
  Widget build(BuildContext context) {
    return TutorControllerProvider(
      controller: widget.controller ?? _defaultController,
      child: TutorScaffold(
        backdropColor: widget.backdropColor ?? Colors.black.withOpacity(0.82),
        tooltipAnimationDuration: widget.backdropAnimationDuration,
        tooltipDelay: widget.backdropAnimationDuration,
        tooltipAnimationCurve: widget.backdropAnimationCurve,
        buildBackdrop: widget.buildBackdrop ??
            (_, controller) => _TutorDefaultBackdrop(
                  controller: controller,
                  tooltipAnimationDuration: widget.tooltipAnimationDuration,
                  tooltipAnimationCurve: widget.tooltipAnimationCurve,
                  onBackdropTap: widget.onBackdropTap,
                ),
        child: widget.child,
      ),
    );
  }
}

class _TutorDefaultBackdrop extends StatelessWidget {
  final TutorController controller;
  final Duration tooltipAnimationDuration;
  final Curve tooltipAnimationCurve;
  final Function(TutorController controller)? onBackdropTap;

  const _TutorDefaultBackdrop({
    super.key,
    required this.controller,
    required this.tooltipAnimationDuration,
    required this.tooltipAnimationCurve,
    this.onBackdropTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBackdropTap == null
          ? controller.next
          : () => onBackdropTap!(controller),
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 0.82),
        duration: tooltipAnimationDuration,
        curve: tooltipAnimationCurve,
        builder: (context, double value, _) {
          return Container(color: Colors.black.withOpacity(value));
        },
      ),
    );
  }
}
