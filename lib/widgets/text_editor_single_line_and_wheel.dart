import 'package:flutter/material.dart';

import 'button.dart';
import 'wheel_selector/models/wheel_selector_value.dart';
import 'wheel_selector/wheel_selector.dart';

class TextEditorSingleLineAndWheel extends StatefulWidget {
  static const height = 144.0;

  final void Function(String name, String unit) onSubmitted;
  final String value;
  final String unit;
  final int? maxLength;
  final String hintText;
  final List<String> options;
  final String buttonLabel;

  const TextEditorSingleLineAndWheel({
    Key? key,
    this.maxLength,
    required this.value,
    required this.unit,
    this.hintText = 'Enter text',
    required this.onSubmitted,
    required this.options,
    required this.buttonLabel,
  }) : super(key: key);

  @override
  State<TextEditorSingleLineAndWheel> createState() =>
      _TextEditorSingleLineAndWheelState();
}

class _TextEditorSingleLineAndWheelState
    extends State<TextEditorSingleLineAndWheel> {
  bool _isEmpty = false;
  String _unit = '';

  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.value;

    setState(() => _unit = widget.unit);

    _updateIsEmpty();
    _controller.addListener(_updateIsEmpty);
  }

  _updateIsEmpty() =>
      setState(() => _isEmpty = _controller.text.isEmpty || _unit.isEmpty);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: TextEditorSingleLineAndWheel.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  autofocus: true,
                  controller: _controller,
                  maxLength: widget.maxLength,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface),
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    fillColor: Theme.of(context).colorScheme.surfaceVariant,
                    filled: true,
                    // border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(width: 24),
              WheelSelector(
                height: 80,
                selectedItemIndex: widget.options.indexOf(_unit),
                childCount: widget.options.length,
                onValueChanged: (unit) => setState(() => _unit = unit),
                convertIndexToValue: (index) => WheelSelectorValue(
                  value: widget.options[index],
                  label: widget.options[index],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Button(
            label: widget.buttonLabel,
            onPressed: _isEmpty
                ? null
                : () => widget.onSubmitted(_controller.text, _unit),
          ),
        ],
      ),
    );
  }
}
