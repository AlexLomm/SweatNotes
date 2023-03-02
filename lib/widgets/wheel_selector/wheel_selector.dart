import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'fade_gradient.dart';
import 'models/wheel_selector_value.dart';
import 'wheel_selector_child.dart';
import 'wheel_selector_highlight.dart';
import 'wheel_selector_wheel.dart';

class WheelSelector<T> extends StatefulWidget {
  static double height = 128.0;

  final double width;
  final int? childCount;

  /// Determines the logic of how an item with an index of "i" is
  /// appearing on the wheel. Example:
  ///
  /// ```
  /// convertIndexToValue(0) // could return '0.25', or 'Foo', etc.
  /// ```
  final WheelSelectorValue<T> Function(int index) convertIndexToValue;
  final void Function(T value) onValueChanged;

  const WheelSelector({
    super.key,
    this.width = 80.0,
    this.childCount,
    required this.convertIndexToValue,
    required this.onValueChanged,
  });

  @override
  State<WheelSelector<T>> createState() => _WheelSelectorState<T>();
}

class _WheelSelectorState<T> extends State<WheelSelector<T>> {
  late final FixedExtentScrollController _controller;

  late final StreamController<T> _streamController;

  @override
  void initState() {
    super.initState();

    _streamController = StreamController<T>.broadcast();

    _streamController.stream
        .distinct()
        .listen((value) => HapticFeedback.lightImpact());

    _controller = FixedExtentScrollController()
      ..addListener(() => _streamController.sink
          .add(widget.convertIndexToValue(_controller.selectedItem).value));
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: WheelSelector.height,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: WheelSelectorWheel(
              controller: _controller,
              childCount: widget.childCount,
              width: widget.width,
              convertIndexToValue: widget.convertIndexToValue,
              onValueChanged: widget.onValueChanged,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: WheelSelectorHighlight(
              width: widget.width,
              height: WheelSelectorChild.height,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: FadeGradient(
              height: 46.0,
              width: widget.width,
              direction: FadeGradientDirection.toBottom,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FadeGradient(
              height: 46.0,
              width: widget.width,
              direction: FadeGradientDirection.toTop,
            ),
          ),
        ],
      ),
    );
  }
}
