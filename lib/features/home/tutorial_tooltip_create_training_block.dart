import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TutorialTooltipCreateTrainingBlock extends StatelessWidget {
  const TutorialTooltipCreateTrainingBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 75,
            child: SvgPicture.asset(
              'assets/tutorial-arrow-pointing-to-circle.svg',
              fit: BoxFit.contain,
            ),
          ),
          Transform.translate(
            offset: const Offset(10, 0),
            child: SizedBox(
              width: 200,
              child: Text(
                'Tap to create a new training block',
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
