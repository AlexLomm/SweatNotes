import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TutorialTooltipTrainingBlock extends StatelessWidget {
  final Rect? paintBounds;

  const TutorialTooltipTrainingBlock({
    super.key,
    required this.paintBounds,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    final offsetFromTop = (paintBounds?.top ?? 0) + mq.padding.top;

    return Transform.translate(
      offset: Offset(
        0,
        -offsetFromTop,
      ),
      child: SizedBox(
        height: mq.size.height,
        width: mq.size.width,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: offsetFromTop - 25,
              left: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/tutorial-swipe-arrow-to-left.svg',
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: 125,
                    child: Text(
                      'Swipe left to archive',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: GoogleFonts.indieFlower().fontFamily,
                        fontWeight: FontWeight.w100,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: offsetFromTop - 25,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Transform.rotate(
                    angle: pi,
                    child: SvgPicture.asset(
                      'assets/tutorial-swipe-arrow-to-left.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: 125,
                    child: Text(
                      'Swipe right to copy',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: GoogleFonts.indieFlower().fontFamily,
                        fontWeight: FontWeight.w100,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: offsetFromTop,
              right: 0,
              left: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Transform.translate(
                    offset: const Offset(-10, 0),
                    child: SvgPicture.asset(
                      'assets/tutorial-long-arrow-up.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(
                      'Tap to view the training block',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: GoogleFonts.indieFlower().fontFamily,
                        fontWeight: FontWeight.w100,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
