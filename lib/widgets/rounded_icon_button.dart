import 'package:flutter/material.dart';

class RoundedIconButton extends StatelessWidget {
  final double size;
  final void Function()? onPressed;

  const RoundedIconButton({
    super.key,
    required this.size,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: SizedBox(
        height: size,
        width: size,
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
