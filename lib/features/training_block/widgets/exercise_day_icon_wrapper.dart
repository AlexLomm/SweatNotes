import 'package:flutter/material.dart';

import '../widget_params.dart';

class ExerciseDayIconWrapper extends StatelessWidget {
  final IconData icon;
  final double? width;

  const ExerciseDayIconWrapper({
    Key? key,
    required this.icon,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: WidgetParams.animationDuration,
      curve: WidgetParams.animationCurve,
      height: double.infinity,
      width: width,
      // this color is needed in order for the entire Container to
      // be tappable. Otherwise, the tap area is only the icon
      color: Colors.white.withOpacity(0.0001),
      child: Icon(
        icon,
        color: Theme.of(context).colorScheme.outline,
      ),
    );
  }
}
