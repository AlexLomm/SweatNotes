import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../features/training_block/widget_params.dart';

class TimerTimeModifierButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const TimerTimeModifierButton({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: WidgetParams.animationDuration,
      curve: WidgetParams.animationCurve,
      opacity: onTap == null ? 0.32 : 1.0,
      child: SizedBox(
        width: 56.0,
        height: 48.0,
        child: MaterialButton(
          onPressed: onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: Theme.of(context).colorScheme.outlineVariant,
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(0),
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontFamily: GoogleFonts.robotoMono().fontFamily,
                    fontSize: 14.0,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
