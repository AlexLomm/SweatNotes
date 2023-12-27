import 'package:flutter/material.dart';

import '../../../features/training_block/widget_params.dart';
import 'core/tutor_scaffold.dart';
import 'core/tutor_controller.dart';

class TutorScaffoldWrapper extends StatefulWidget {
  final Widget child;

  final Function(TutorController controller) onTap;

  const TutorScaffoldWrapper({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  State<TutorScaffoldWrapper> createState() => _TutorScaffoldWrapperState();
}

class _TutorScaffoldWrapperState extends State<TutorScaffoldWrapper> {
  final TutorController _controller = TutorController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TutorScaffold(
      controller: _controller,
      tooltipAnimationDuration: WidgetParams.tutorialBackdropAnimationDuration,
      tooltipAnimationCurve: WidgetParams.tutorialAnimationCurve,
      preferredOverlay: GestureDetector(
        onTap: () => widget.onTap(_controller),
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 0.82),
          duration: WidgetParams.tutorialTooltipAnimationDuration,
          curve: WidgetParams.tutorialAnimationCurve,
          builder: (context, double value, _) {
            return Container(color: Colors.black.withOpacity(value));
          },
        ),
      ),
      builder: (BuildContext context) => widget.child,
    );
  }
}
