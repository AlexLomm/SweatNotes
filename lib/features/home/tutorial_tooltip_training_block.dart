import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TutorialTooltipTrainingBlock extends StatelessWidget {
  final Size childSize;

  const TutorialTooltipTrainingBlock({
    super.key,
    required this.childSize,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    final offsetFromTop = childSize.height;

    return Transform.translate(
      offset: Offset(
        0,
        -offsetFromTop,
      ),
      child: SizedBox(
        height: mq.size.height,
        width: childSize.width,
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
                    width: 100,
                    child: Text(
                      '1. Swipe left to archive',
                      style: TextStyle(
                        fontSize: 20.0,
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Transform.rotate(
                    angle: pi,
                    child: SvgPicture.asset(
                      'assets/tutorial-swipe-arrow-to-left.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      '3. Swipe right to copy',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 20.0,
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
                  Transform.rotate(
                    angle: pi / 2,
                    child: SvgPicture.asset(
                      'assets/tutorial-swipe-arrow-to-left.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: 140,
                    child: Text(
                      '2. Tap to view the training plan',
                      style: TextStyle(
                        fontSize: 20.0,
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
