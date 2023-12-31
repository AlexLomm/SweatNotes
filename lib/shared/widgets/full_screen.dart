import 'package:flutter/material.dart';

class FullScreen extends StatelessWidget {
  final Widget child;

  const FullScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    final appBarHeight = Scaffold.of(context).appBarMaxHeight ?? 0;
    final safeAreaHeight =
        mq.size.height - mq.padding.top - mq.padding.bottom - appBarHeight;

    return SizedBox(
      height: safeAreaHeight,
      width: mq.size.width,
      child: child,
    );
  }
}
