import 'package:flutter/material.dart';
import 'package:selector_wheel/selector_wheel.dart';

class LoadSelector extends StatefulWidget {
  final double value;
  final void Function(double) onChange;

  final int stepFirst;
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
  int firstValue = 0;
  double secondValue = 0;

  double get combinedValue => firstValue + secondValue;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface);

    return Column(children: [
      Text('Load', style: textTheme),
      const SizedBox(height: 8),
      Row(
        children: [
          SizedBox(
            height: 128.0,
            child: SelectorWheel(
              childCount: widget.stepsCountFirst,
              selectedItemIndex: _convertFirstValueToIndex(widget.value),
              convertIndexToValue: _convertFirstIndexToValue,
              onValueChanged: (value) {
                setState(() => firstValue = value.value);
                widget.onChange(combinedValue);
              },
            ),
          ),
          const SizedBox(width: 4.0),
          SizedBox(
            height: 128.0,
            child: SelectorWheel(
              selectedItemIndex: _convertSecondValueToIndex(widget.value),
              convertIndexToValue: _convertSecondIndexToValue,
              onValueChanged: (value) {
                setState(() => secondValue = value.value);
                widget.onChange(combinedValue);
              },
            ),
          ),
        ],
      ),
    ]);
  }

  SelectorWheelValue<int> _convertFirstIndexToValue(int i) {
    final value = i * widget.stepFirst;

    return SelectorWheelValue(label: '$value', value: value, index: i);
  }

  SelectorWheelValue<double> _convertSecondIndexToValue(int i) {
    final value = i * widget.stepSecond;

    return SelectorWheelValue(label: '$value', value: value, index: i);
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
