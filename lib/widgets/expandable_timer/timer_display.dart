import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/format_seconds_into_timer_string.dart';
import 'timer_custom_input.dart';

class TimerDisplay extends StatelessWidget {
  final int seconds;
  final VoidCallback? onTap;

  const TimerDisplay({
    super.key,
    this.onTap,
    required this.seconds,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: TimerCustomInput.height,
      width: TimerCustomInput.width,
      child: Center(
        child: GestureDetector(
          onTap: onTap,
          child: Text(
            formatSecondsIntoTimerString(seconds),
            softWrap: false,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontFamily: GoogleFonts.robotoMono().fontFamily,
                  fontSize: 45.0,
                ),
          ),
        ),
      ),
    );
  }
}
