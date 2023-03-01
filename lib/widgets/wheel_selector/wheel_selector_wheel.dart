import 'package:flutter/cupertino.dart';
import 'package:journal_flutter/widgets/wheel_selector/wheel_selector_child.dart';

import 'custom_fixed_extent_scroll_physics.dart';
import 'models/wheel_selector_value.dart';

class WheelSelectorWheel<T> extends StatelessWidget {
  final double width;
  final int? childCount;
  final FixedExtentScrollController controller;
  final WheelSelectorValue<T> Function(int index) convertIndexToValue;
  final void Function(T value) onValueChanged;

  const WheelSelectorWheel({
    Key? key,
    required this.width,
    required this.childCount,
    required this.controller,
    required this.convertIndexToValue,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollEndNotification) {
            final index = controller.selectedItem;

            final value = convertIndexToValue(index).value;

            onValueChanged(value);
          }

          return false;
        },
        child: ListWheelScrollView.useDelegate(
          controller: controller,
          itemExtent: WheelSelectorChild.height,
          perspective: 0.009,
          diameterRatio: 2.0,
          physics: const CustomFixedExtentScrollPhysics(),
          childDelegate: ListWheelChildBuilderDelegate(
            childCount: childCount,
            builder: (context, index) {
              return WheelSelectorChild(
                width: width,
                value: convertIndexToValue(index).label,
              );
            },
          ),
        ),
      ),
    );
  }
}
