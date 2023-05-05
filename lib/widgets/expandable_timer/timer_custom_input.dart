import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selector_wheel/selector_wheel.dart';

class TimerCustomInput extends StatefulWidget {
  static const height = 144.0;
  static const width = 172.0;

  final bool isActive;
  final int initialValue;
  final Function(int value) onChange;

  const TimerCustomInput({
    Key? key,
    required this.isActive,
    this.initialValue = 0,
    required this.onChange,
  }) : super(key: key);

  @override
  State<TimerCustomInput> createState() => _TimerCustomInputState();
}

class _TimerCustomInputState extends State<TimerCustomInput> {
  late int _seconds;
  late int _minutes;

  @override
  void initState() {
    super.initState();

    setState(() {
      _seconds = widget.initialValue % 60;
      _minutes = widget.initialValue ~/ 60;
    });
  }

  @override
  void didUpdateWidget(TimerCustomInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialValue != widget.initialValue) {
      setState(() {
        _seconds = widget.initialValue % 60;
        _minutes = widget.initialValue ~/ 60;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleLargeTheme = Theme.of(context).textTheme.titleLarge?.copyWith(
          fontSize: 57.0,
          color: Theme.of(context).colorScheme.primary,
          fontFamily: GoogleFonts.robotoMono().fontFamily,
        );

    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              onSurface: Theme.of(context).colorScheme.primary,
              surface: ElevationOverlay.applySurfaceTint(
                Theme.of(context).colorScheme.surface,
                Theme.of(context).colorScheme.primary,
                3.0,
              ),
            ),
        textTheme: Theme.of(context).textTheme.copyWith(titleLarge: titleLargeTheme),
      ),
      child: SizedBox(
        width: TimerCustomInput.width,
        child: Row(
          children: [
            // the offset is needed to correctly align the wheel selector
            // texts with the regular timer display text
            Transform.translate(
              offset: const Offset(0, -1.5),
              child: SizedBox(
                height: TimerCustomInput.height,
                child: SelectorWheel<int>(
                  highlightWidth: 0,
                  highlightHeight: 0,
                  childCount: 60,
                  childHeight: 68.0,
                  width: 66.0,
                  selectedItemIndex: _minutes,
                  enableHapticFeedback: widget.isActive,
                  convertIndexToValue: (index) => SelectorWheelValue(
                    label: '$index'.padLeft(2, '0'),
                    value: index,
                    index: index,
                  ),
                  onValueChanged: (wheelValue) {
                    setState(() => _minutes = wheelValue.value);

                    if (!widget.isActive) return;

                    widget.onChange(_minutes * 60 + _seconds);
                  },
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(2.0, 0.5),
              child: Text(':', style: titleLargeTheme),
            ),
            Transform.translate(
              offset: const Offset(0, -1.5),
              child: SizedBox(
                height: TimerCustomInput.height,
                child: SelectorWheel<int>(
                  highlightWidth: 0,
                  highlightHeight: 0,
                  childCount: 60,
                  childHeight: 68.0,
                  width: 71.0,
                  selectedItemIndex: _seconds,
                  enableHapticFeedback: widget.isActive,
                  convertIndexToValue: (index) => SelectorWheelValue(
                    label: '$index'.padLeft(2, '0'),
                    value: index,
                    index: index,
                  ),
                  onValueChanged: (wheelValue) {
                    setState(() => _seconds = wheelValue.value);

                    if (!widget.isActive) return;

                    widget.onChange(_minutes * 60 + _seconds);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
