import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String? helperText;
  final TextEditingController controller;

  const PasswordField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.helperText,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: !_isPasswordVisible,
      controller: widget.controller,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
      decoration: InputDecoration(
        filled: true,
        suffixIcon: IconButton(
          icon: Icon(_isPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined),
          onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
        ),
        fillColor: Theme.of(context).colorScheme.surfaceVariant,
        labelText: widget.labelText,
        hintText: widget.hintText,
        helperText: widget.helperText,
      ),
    );
  }
}
