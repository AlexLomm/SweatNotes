import 'package:flutter/material.dart';

import 'timer_control_button.dart';

class TimerPlayPauseButton extends StatelessWidget {
  final bool isDisabled;
  final bool isPlaying;
  final VoidCallback? onTapPlay;
  final VoidCallback? onTapPause;

  const TimerPlayPauseButton({
    super.key,
    this.isDisabled = false,
    required this.isPlaying,
    required this.onTapPlay,
    required this.onTapPause,
  });

  @override
  Widget build(BuildContext context) {
    return TimerControlButton(
      dimension: 64.0,
      icon: isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
      onTap: isDisabled ? null : _playPause,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  _playPause() {
    if (isPlaying) {
      onTapPause?.call();
    } else {
      onTapPlay?.call();
    }
  }
}
