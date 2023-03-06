import 'package:flutter/material.dart';

import '../../../widgets/wheel_selector/models/wheel_selector_value.dart';
import '../../../widgets/wheel_selector/wheel_selector.dart';

class LoadSelector extends StatefulWidget {
  final double value;
  final void Function(double) onChange;

  final double stepFirst;
  final int stepsCountFirst;

  final double stepSecond;
  final int stepsCountSecond;

  const LoadSelector({
    Key? key,
    required this.value,
    required this.onChange,
    required this.stepFirst,
    required this.stepsCountFirst,
    required this.stepSecond,
    required this.stepsCountSecond,
  }) : super(key: key);

  @override
  State<LoadSelector> createState() => _LoadSelectorState();
}

class _LoadSelectorState extends State<LoadSelector> {
  double firstValue = 0;
  double secondValue = 0;

  double get combinedValue => firstValue + secondValue;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .bodyLarge
        ?.copyWith(color: Theme.of(context).colorScheme.onSurface);

    return Column(children: [
      Text('Load', style: textTheme),
      const SizedBox(height: 8),
      Row(
        children: [
          WheelSelector(
            childCount: widget.stepsCountFirst,
            selectedItemIndex: _convertFirstValueToIndex(widget.value),
            convertIndexToValue: _convertFirstIndexToValue,
            onValueChanged: (double value) {
              setState(() => firstValue = value);
              widget.onChange(combinedValue);
            },
          ),
          const SizedBox(width: 4.0),
          WheelSelector(
            childCount: widget.stepsCountSecond,
            selectedItemIndex: _convertSecondValueToIndex(widget.value),
            convertIndexToValue: _convertSecondIndexToValue,
            onValueChanged: (double value) {
              setState(() => secondValue = value);
              widget.onChange(combinedValue);
            },
          ),
        ],
      ),
    ]);
  }

  WheelSelectorValue<double> _convertFirstIndexToValue(int i) {
    final value = i * widget.stepFirst;

    return WheelSelectorValue(label: '$value', value: value);
  }

  WheelSelectorValue<double> _convertSecondIndexToValue(int i) {
    final value = i * widget.stepSecond;

    return WheelSelectorValue(label: '$value', value: value);
  }

  int _convertFirstValueToIndex(double value) {
    final remainder = value % widget.stepFirst;

    return (value - remainder) ~/ widget.stepFirst;
  }

  int _convertSecondValueToIndex(double value) {
    final remainder = value % widget.stepFirst;

    return remainder ~/ widget.stepSecond;
  }
}
