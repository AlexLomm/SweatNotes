import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class EmptyPagePlaceholder extends StatelessWidget {
  const EmptyPagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: mq.size.height * 0.75,
      width: mq.size.width * 0.75,
      child: RiveAnimation.asset(
        alignment: Alignment.center,
        isDark
            ? 'assets/rive/empty-state-dark.riv'
            : 'assets/rive/empty-state-light.riv',
      ),
    );
  }
}
