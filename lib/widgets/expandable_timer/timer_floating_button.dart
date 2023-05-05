import 'package:flutter/material.dart';

import '../../utils/format_seconds_into_timer_string.dart';

class TimerFloatingButton extends StatelessWidget {
  static const double width = 56.0;
  static const double height = 56.0;

  final VoidCallback? onTap;
  final bool isPlaceholder;
  final int? seconds;

  const TimerFloatingButton({
    Key? key,
    this.onTap,
    this.isPlaceholder = false,
    this.seconds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    );

    return IgnorePointer(
      ignoring: isPlaceholder,
      child: Material(
        elevation: 3.0,
        shadowColor: isPlaceholder ? Colors.transparent : null,
        color: Theme.of(context).colorScheme.surface,
        // surfaceTintColor is not available on the MaterialButton() widget
        // and that's why we're wrapping it in a Material() widget
        surfaceTintColor: Theme.of(context).colorScheme.primary,
        shape: shape,
        child: SizedBox(
          width: width,
          height: height,
          child: MaterialButton(
            padding: EdgeInsets.zero,
            elevation: 0,
            color: Colors.transparent,
            shape: shape,
            onPressed: onTap ?? () {},
            child: Center(
              child: seconds == null
                  ? const Icon(Icons.timer_outlined)
                  : Text(
                      formatSecondsIntoTimerString(seconds),
                      softWrap: false,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
