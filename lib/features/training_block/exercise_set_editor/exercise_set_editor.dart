import 'package:flutter/material.dart';

import '../../../widgets/button.dart';
import '../../../widgets/wheel_selector/wheel_selector.dart';
import 'load_selector.dart';
import 'reps_selector.dart';
import 'vertical_divider.dart';

class ExerciseSetEditor extends StatefulWidget {
  static const height = 252.0;

  final int reps;
  final double load;
  final Function({required String reps, required String load}) onChange;

  const ExerciseSetEditor({
    Key? key,
    required this.reps,
    required this.load,
    required this.onChange,
  }) : super(key: key);

  @override
  State<ExerciseSetEditor> createState() => _ExerciseSetEditorState();
}

class _ExerciseSetEditorState extends State<ExerciseSetEditor> {
  int _reps = 0;
  double _load = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: ExerciseSetEditor.height,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RepsSelector(
                  value: widget.reps,
                  onChange: (value) => setState(() => _reps = value),
                  // TODO: pass these from outside
                  step: 1,
                  stepsCount: 100,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 32.0),
                  child: VerticalDividerWithGradient(
                    height: WheelSelector.defaultHeight,
                  ),
                ),
                LoadSelector(
                  value: widget.load,
                  onChange: (value) => setState(() => _load = value),
                  // TODO: pass these from outside
                  stepFirst: 5,
                  stepsCountFirst: 100,
                  stepSecond: 0.25,
                  stepsCountSecond: 20,
                )
              ],
            ),
            const SizedBox(height: 24),
            Button(
              label: 'Save',
              onPressed: () => widget.onChange(
                reps: _reps.toString(),
                load: _load.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}