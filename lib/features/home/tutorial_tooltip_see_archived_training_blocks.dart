import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TutorialTooltipSeeArchivedTrainingBlocks extends StatelessWidget {
  const TutorialTooltipSeeArchivedTrainingBlocks({super.key});

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
              'assets/tutorial-arrow-pointing-to-wave.svg',
              fit: BoxFit.contain,
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -10),
            child: SizedBox(
              width: 225,
              child: Text(
                'Tap to view archived training blocks',
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
