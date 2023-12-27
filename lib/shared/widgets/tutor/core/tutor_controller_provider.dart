import 'package:flutter/material.dart';

import 'tutor_controller.dart';

class TutorControllerProvider extends InheritedWidget {
  final TutorController controller;

  const TutorControllerProvider({
    super.key,
    required this.controller,
    required super.child,
  });

  static TutorControllerProvider of(BuildContext context) {
    final TutorControllerProvider? result =
        context.dependOnInheritedWidgetOfExactType<TutorControllerProvider>();

    assert(
      result != null,
      'TutorInherited.of() called with a context that does not contain TutorInherited.',
    );

    return result!;
  }

  @override
  bool updateShouldNotify(TutorControllerProvider oldWidget) {
    return oldWidget.controller != controller;
  }
}
