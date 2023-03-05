import 'package:flutter/material.dart';

class TextArea extends StatelessWidget {
  final bool autofocus;
  final TextEditingController controller;
  final int? maxLength;
  final String hintText;

  const TextArea({
    Key? key,
    this.autofocus = false,
    required this.controller,
    this.maxLength,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        autofocus: autofocus,
        controller: controller,
        maxLength: maxLength,
        maxLines: 7,
        autocorrect: false,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.all(16),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
