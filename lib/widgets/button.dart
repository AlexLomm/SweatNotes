import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final double borderRadius;
  final EdgeInsets padding;
  final Color? backgroundColor;
  final Widget? child;
  final void Function()? onPressed;

  const Button({
    Key? key,
    required this.label,
    this.borderRadius = 100,
    this.padding = const EdgeInsets.symmetric(vertical: 12),
    this.backgroundColor,
    this.child,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labelLarge = Theme.of(context).textTheme.labelLarge;

    final onPrimaryColor = Theme.of(context).colorScheme.onPrimary;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        iconColor: MaterialStateProperty.resolveWith((_) => onPrimaryColor),
        shape: MaterialStateProperty.resolveWith(
          (_) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        padding: MaterialStateProperty.resolveWith(
          (_) => padding,
        ),
        textStyle: MaterialStateProperty.resolveWith(
          (_) => labelLarge?.copyWith(color: onPrimaryColor),
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
          (state) {
            final color = backgroundColor ?? primaryColor;

            if (state.contains(MaterialState.disabled)) {
              return color.withOpacity(0.32);
            }

            return color;
          },
        ),
      ),
      child: child ??
          Text(label, style: labelLarge?.copyWith(color: onPrimaryColor)),
    );
  }
}
