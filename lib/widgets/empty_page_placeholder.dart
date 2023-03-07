import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class EmptyPagePlaceholder extends StatelessWidget {
  const EmptyPagePlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    // TODO: add dark mode
    return SizedBox(
      height: mq.size.height * 0.75,
      width: mq.size.width * 0.75,
      child: const RiveAnimation.asset(
        alignment: Alignment.center,
        'assets/rive/empty-state-home-light.riv',
      ),
    );
  }
}
