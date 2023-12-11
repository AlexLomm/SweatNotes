import 'package:flutter/material.dart';

import 'button.dart';
import 'text_area.dart';

class TextEditorMultiLine extends StatefulWidget {
  static const height = 268.0;

  final Function(String) onSubmitted;
  final String value;
  final int? maxLength;
  final String hintText;

  const TextEditorMultiLine({
    super.key,
    this.maxLength,
    required this.value,
    this.hintText = 'Enter text',
    required this.onSubmitted,
  });

  @override
  State<TextEditorMultiLine> createState() => _TextEditorMultiLineState();
}

class _TextEditorMultiLineState extends State<TextEditorMultiLine> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.value;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: TextEditorMultiLine.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextArea(
              autofocus: true,
              controller: _controller,
              maxLength: widget.maxLength,
              hintText: widget.hintText,
            ),
            const SizedBox(height: 24),
            Button(
              label: 'Done',
              onPressed: () => widget.onSubmitted(_controller.text),
            ),
          ],
        ),
      ),
    );
  }
}
