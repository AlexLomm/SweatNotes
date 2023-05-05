import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'timer_custom_input.dart';

class TimerDisplay extends StatelessWidget {
  final int seconds;
  final VoidCallback? onTap;

  String get secondsLeft => (seconds % 60).toString().padLeft(2, '0');

  String get minutesLeft => (seconds ~/ 60).toString().padLeft(2, '0');

  const TimerDisplay({
    Key? key,
    this.onTap,
    required this.seconds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: TimerCustomInput.height,
      width: TimerCustomInput.width,
      child: Center(
        child: GestureDetector(
          onTap: onTap,
          child: Text(
            '$minutesLeft:$secondsLeft',
            softWrap: false,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontFamily: GoogleFonts.robotoMono().fontFamily,
                  fontSize: 57.0,
                ),
          ),
        ),
      ),
    );
  }
}
