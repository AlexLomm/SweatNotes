import 'package:flutter/material.dart';
import 'package:selector_wheel/selector_wheel.dart';

class RepsSelector extends StatelessWidget {
  final int value;
  final void Function(int) onChange;

  final int step;
  final int stepsCount;

  const RepsSelector({
    Key? key,
    required this.value,
    required this.onChange,
    required this.step,
    required this.stepsCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface);

    return Column(
      children: [
        Text('Reps', style: textTheme),
        const SizedBox(height: 8),
        SizedBox(
          height: 80,
          child: SelectorWheel(
            childCount: stepsCount,
            selectedItemIndex: _convertValueToIndex(value),
            convertIndexToValue: _convertIndexToValue,
            onValueChanged: (value) => onChange(value.value),
          ),
        ),
      ],
    );
  }

  SelectorWheelValue<int> _convertIndexToValue(int i) {
    final value = (i * step).toInt();

    return SelectorWheelValue(label: '$value', value: value, index: i);
  }

  int _convertValueToIndex(int value) {
    return value ~/ step;
  }
}
