import 'package:flutter/material.dart';

import 'timer_control_button.dart';

class TimerPlaceholderButton extends StatelessWidget {
  const TimerPlaceholderButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TimerControlButton(
      dimension: 40.0,
      isPlaceholder: true,
    );
  }
}
