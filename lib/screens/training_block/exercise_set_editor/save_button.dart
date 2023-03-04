import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final void Function() onPressed;

  const SaveButton({Key? key, required this.onPressed}) : super(key: key);

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
        'Save',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
    );
  }
}
