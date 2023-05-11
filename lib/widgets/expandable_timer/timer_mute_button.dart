import 'package:flutter/material.dart';

import 'timer_control_button.dart';

class TimerMuteButton extends StatelessWidget {
  final void Function(bool)? onTap;
  final bool isMuted;

  const TimerMuteButton({
    Key? key,
    required this.onTap,
    required this.isMuted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimerControlButton(
      dimension: 40.0,
      icon: isMuted ? Icons.volume_off : Icons.volume_up,
      onTap: () => onTap?.call(!isMuted),
      color: Theme.of(context).colorScheme.secondary,
    );
  }
}
