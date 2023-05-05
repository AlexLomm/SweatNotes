import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../features/training_block/widget_params.dart';

class TimerTimeModifierButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const TimerTimeModifierButton({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: WidgetParams.animationDuration,
      curve: WidgetParams.animationCurve,
      opacity: onTap == null ? 0.32 : 1.0,
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
        child: SizedBox(
          width: 72.0,
          height: 56.0,
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontFamily: GoogleFonts.robotoMono().fontFamily,
                    fontSize: 28.0,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
