import 'package:flutter/material.dart';

import 'timer_control_button.dart';

class TimerMuteButton extends StatelessWidget {
  final void Function(bool)? onTap;
  final bool isMuted;

  const TimerMuteButton({
    super.key,
    required this.onTap,
    required this.isMuted,
  });

  @override
  Widget build(BuildContext context) {
    return TimerControlButton(
      dimension: 40.0,
      icon: isMuted ? Icons.volume_up : Icons.volume_off,
      onTap: () => onTap?.call(!isMuted),
      color: Theme.of(context).colorScheme.secondary,
    );
  }
}
