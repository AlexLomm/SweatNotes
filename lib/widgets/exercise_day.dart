import 'package:flutter/material.dart';

import 'exercise_type.dart';

class ExerciseDay extends StatelessWidget {
  static const width = 144.0;

  final String name;

  const ExerciseDay({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(-16, 0),
      child: Container(
        width: width,
        clipBehavior: Clip.none,
        margin: const EdgeInsets.only(top: 24),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(103, 80, 164, 0.08),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 16,
              offset: Offset(0, 4),
            ),
          ],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 18,
                left: 16,
                right: 16,
                bottom: 10,
              ),
              child: _LeftPadding(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(16, 0),
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: const ExerciseType(name: 'Bench Press'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LeftPadding extends StatelessWidget {
  final Widget child;

  const _LeftPadding({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      child: child,
    );
  }
}
