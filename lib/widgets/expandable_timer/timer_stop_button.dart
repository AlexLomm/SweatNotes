import 'package:flutter/material.dart';

import 'timer_control_button.dart';

class TimerStopButton extends StatelessWidget {
  final VoidCallback? onTap;

  const TimerStopButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimerControlButton(
      dimension: 40.0,
      icon: Icons.stop_rounded,
      onTap: onTap,
      color: Theme.of(context).colorScheme.secondary,
    );
  }
}
