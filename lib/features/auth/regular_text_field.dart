import 'package:flutter/material.dart';

class RegularTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;

  const RegularTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceVariant,
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }
}
