import 'package:flutter/material.dart';

import '../../../widgets/wheel_selector/models/wheel_selector_value.dart';
import '../../../widgets/wheel_selector/wheel_selector.dart';

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
    final textTheme = Theme.of(context)
        .textTheme
        .bodyLarge
        ?.copyWith(color: Theme.of(context).colorScheme.onSurface);

    return Column(
      children: [
        Text('Reps', style: textTheme),
        const SizedBox(height: 8),
        WheelSelector(
          childCount: stepsCount,
          selectedItemIndex: _convertValueToIndex(value),
          convertIndexToValue: _convertIndexToValue,
          onValueChanged: (value) => onChange(value),
        ),
      ],
    );
  }

  WheelSelectorValue<int> _convertIndexToValue(int i) {
    final value = (i * step).toInt();

    return WheelSelectorValue(label: '$value', value: value);
  }

  int _convertValueToIndex(int value) {
    return value ~/ step;
  }
}
