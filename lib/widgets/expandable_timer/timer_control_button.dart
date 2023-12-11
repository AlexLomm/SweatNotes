import 'package:flutter/material.dart';

import '../../features/training_block/widget_params.dart';

class TimerControlButton extends StatelessWidget {
  final bool isPlaceholder;
  final double dimension;
  final IconData? icon;
  final Color? color;
  final VoidCallback? onTap;

  const TimerControlButton({
    super.key,
    this.isPlaceholder = false,
    required this.dimension,
    this.icon,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: dimension,
      height: dimension,
      child: isPlaceholder
          ? null
          : AnimatedOpacity(
              duration: WidgetParams.animationDuration,
              curve: WidgetParams.animationCurve,
              opacity: onTap == null ? 0.32 : 1.0,
              child: MaterialButton(
                elevation: 0,
                padding: EdgeInsets.zero,
                onPressed: onTap,
                disabledColor: Theme.of(context).colorScheme.surfaceVariant,
                color: Theme.of(context).colorScheme.surfaceVariant,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.25 * dimension),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: 0.63 * dimension,
                    color: color,
                  ),
                ),
              ),
            ),
    );
  }
}
