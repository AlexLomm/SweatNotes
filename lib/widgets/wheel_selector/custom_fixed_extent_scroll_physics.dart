import 'package:flutter/material.dart';

class CustomFixedExtentScrollPhysics extends FixedExtentScrollPhysics {
  const CustomFixedExtentScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  SpringDescription get spring {
    return const SpringDescription(
      mass: 20,
      stiffness: 300,
      damping: 1.0,
    );
  }

  @override
  CustomFixedExtentScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomFixedExtentScrollPhysics(parent: buildParent(ancestor));
  }
}
