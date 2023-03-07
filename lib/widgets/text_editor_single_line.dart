import 'package:flutter/material.dart';

import 'button.dart';

class TextEditorSingleLine extends StatefulWidget {
  static const height = 52.0;

  final Function(String) onSubmitted;
  final String value;
  final int? maxLength;
  final String hintText;

  const TextEditorSingleLine({
    Key? key,
    this.maxLength,
    required this.value,
    this.hintText = 'Enter text',
    required this.onSubmitted,
  }) : super(key: key);

  @override
  State<TextEditorSingleLine> createState() => _TextEditorSingleLineState();
}

class _TextEditorSingleLineState extends State<TextEditorSingleLine> {
  bool _isEmpty = false;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.value;

    _updateIsEmpty();
    _controller.addListener(_updateIsEmpty);
  }

  _updateIsEmpty() => setState(() => _isEmpty = _controller.text.isEmpty);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: TextEditorSingleLine.height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                autofocus: true,
                controller: _controller,
                maxLength: widget.maxLength,
                keyboardType: TextInputType.text,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  fillColor: Theme.of(context).colorScheme.surfaceVariant,
                  filled: true,
                  // border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(width: 24),
            Button(
              label: 'Done',
              onPressed:
                  _isEmpty ? null : () => widget.onSubmitted(_controller.text),
            ),
          ],
        ),
      ),
    );
  }
}
