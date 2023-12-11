import 'package:flutter/material.dart';

import 'button.dart';
import 'custom_dismissible.dart';

class DismissibleButton extends StatelessWidget {
  final String id;
  final String label;
  final VoidCallback onPressed;
  final Future<bool?> Function(DismissDirection direction)? confirmDismiss;
  final DismissDirectionCallback? onDismissed;
  final Widget? right;
  final Color? textColor;
  final Color? backgroundColor;
  final bool isArchivable;

  const DismissibleButton({
    super.key,
    required this.id,
    required this.label,
    required this.onPressed,
    this.confirmDismiss,
    this.onDismissed,
    this.right,
    this.textColor,
    this.backgroundColor,
    this.isArchivable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      child: CustomDismissible(
        id: id,
        borderRadius: BorderRadius.circular(12.0),
        isEnabled: onDismissed != null,
        isArchivable: isArchivable,
        confirmDismiss: confirmDismiss,
        onDismissed: onDismissed ?? (_) {},
        child: Button(
          borderRadius: 0,
          backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primaryContainer,
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24.0,
          ),
          label: label,
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: textColor ?? Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              ),
              if (right != null) right!,
            ],
          ),
        ),
      ),
    );
  }
}
