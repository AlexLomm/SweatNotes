import 'package:flutter/material.dart';
import 'package:journal_flutter/widgets/text_area.dart';

import 'button.dart';

class TextEditor extends StatefulWidget {
  static const height = 268.0;

  final Function(String) onSubmitted;
  final String value;
  final int? maxLength;
  final String hintText;

  const TextEditor({
    Key? key,
    this.maxLength,
    required this.value,
    this.hintText = 'Enter text',
    required this.onSubmitted,
  }) : super(key: key);

  @override
  State<TextEditor> createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
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
      child: Container(
        height: TextEditor.height,
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
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
              onPressed: _controller.text.isEmpty
                  ? null
                  : () => widget.onSubmitted(_controller.text),
            ),
          ],
        ),
      ),
    );
  }
}
