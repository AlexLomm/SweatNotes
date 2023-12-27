import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TutorialTooltipSeeSettings extends StatelessWidget {
  const TutorialTooltipSeeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(10, -30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 75,
            child: SvgPicture.asset(
              'assets/tutorial-double-arrow-pointing-to-underline.svg',
              fit: BoxFit.contain,
            ),
          ),
          Transform.translate(
            offset: const Offset(-20, -10),
            child: SizedBox(
              width: 250,
              child: Text(
                'Tap to view and change settings to your liking.\n\nYou can customize theme, reset tutorials, etc.',
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: GoogleFonts.indieFlower().fontFamily,
                  fontWeight: FontWeight.w100,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
