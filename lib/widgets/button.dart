import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final void Function()? onPressed;

  const Button({
    Key? key,
    required this.label,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.resolveWith(
          (_) => const EdgeInsets.symmetric(vertical: 12),
        ),
        textStyle: MaterialStateProperty.resolveWith(
          (_) => Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
          (_) => Theme.of(context).colorScheme.primary,
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
    );
  }
}
