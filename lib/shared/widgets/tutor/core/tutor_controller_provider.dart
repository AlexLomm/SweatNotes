import 'package:flutter/material.dart';

import 'tutor_controller.dart';

class TutorControllerProvider extends InheritedWidget {
  final TutorController controller;

  const TutorControllerProvider({
    super.key,
    required this.controller,
    required super.child,
  });

  // returning nullable value is intentional. Otherwise asserting against null
  // and forcing a non-nullable value causes an error when dragging and dropping
  // in a ReorderableListView
  static TutorControllerProvider? of(BuildContext context) {
    final TutorControllerProvider? result =
        context.dependOnInheritedWidgetOfExactType<TutorControllerProvider>();

    if (result == null) {
      debugPrint(
        'TutorControllerProvider.of() called with a context that does not contain TutorControllerProvider.',
      );
    }

    return result;
  }

  @override
  bool updateShouldNotify(TutorControllerProvider oldWidget) {
    return oldWidget.controller != controller;
  }
}
