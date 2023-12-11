import 'package:flutter/material.dart';

import '../../../../widgets/button.dart';
import 'load_selector.dart';
import 'reps_selector.dart';
import 'vertical_divider.dart';

class ExerciseSetEditor extends StatefulWidget {
  static const height = 252.0;

  final int reps;
  final double load;
  final Function({required int reps, required double load}) onChange;

  const ExerciseSetEditor({
    super.key,
    required this.reps,
    required this.load,
    required this.onChange,
  });

  @override
  State<ExerciseSetEditor> createState() => _ExerciseSetEditorState();
}

class _ExerciseSetEditorState extends State<ExerciseSetEditor> {
  int _reps = 0;
  double _load = 0;

  @override
  void initState() {
    super.initState();

    _reps = widget.reps;
    _load = widget.load;
  }

  @override
  void didUpdateWidget(ExerciseSetEditor oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.reps != oldWidget.reps) {
      _reps = widget.reps;
    }

    if (widget.load != oldWidget.load) {
      _load = widget.load;
    }
  }

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
                  value: _reps,
                  onChange: (value) => setState(() => _reps = value),
                  // TODO: pass these from outside
                  step: 1,
                  stepsCount: 100,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 32.0),
                  child: VerticalDividerWithGradient(height: 128.0),
                ),
                LoadSelector(
                  value: _load,
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
              onPressed: () => widget.onChange(reps: _reps, load: _load),
            ),
          ],
        ),
      ),
    );
  }
}
