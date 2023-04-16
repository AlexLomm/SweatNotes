import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegularTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final int? maxLength;

  const RegularTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: maxLength,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
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
