import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String? label;
  final double borderRadius;
  final EdgeInsets padding;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Widget? child;
  final bool isLoading;
  final void Function()? onPressed;

  const Button({
    super.key,
    this.label,
    this.borderRadius = 100,
    this.padding = const EdgeInsets.symmetric(vertical: 12),
    this.backgroundColor,
    this.foregroundColor,
    this.child,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final labelLarge = Theme.of(context).textTheme.labelLarge;

    final onPrimaryColor = Theme.of(context).colorScheme.onPrimary;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        padding: padding,
        foregroundColor: foregroundColor ?? onPrimaryColor,
        backgroundColor: backgroundColor ?? primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        textStyle: labelLarge?.copyWith(color: onPrimaryColor),
      ),
      child: child ?? Text(label ?? ''),
    );
  }
}
