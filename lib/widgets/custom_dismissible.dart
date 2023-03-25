import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import '../features/training_block/widget_params.dart';

class CustomDismissible extends StatefulWidget {
  final bool isEnabled;
  final String id;
  final BorderRadius borderRadius;
  final Widget child;
  final DismissDirectionCallback onDismissed;
  final DismissUpdateCallback? onUpdate;
  final Alignment iconAlignment;

  const CustomDismissible({
    Key? key,
    this.isEnabled = true,
    required this.id,
    required this.borderRadius,
    required this.child,
    required this.onDismissed,
    this.iconAlignment = Alignment.centerRight,
    this.onUpdate,
  }) : super(key: key);

  @override
  State<CustomDismissible> createState() => _CustomDismissibleState();
}

class _CustomDismissibleState extends State<CustomDismissible> {
  Timer? _timerToReset;
  int _counter = 0;

  bool _isConfirmed = false;

  @override
  void didUpdateWidget(CustomDismissible oldWidget) {
    super.didUpdateWidget(oldWidget);

    // reset the widget's state if the isEnabled property has changed.
    // this is useful, when the swipe action is cancelled mid-swipe.
    if (oldWidget.isEnabled != widget.isEnabled && !widget.isEnabled) {
      _timerToReset?.cancel();

      // the timer is needed for the "reset" not to interfere with the animations.
      // I.e the reset should happen after the animations have finished.
      //
      // Also, the timer takes `timeDilation` into consideration in order
      // for it to work seamlessly with the debugger "Slow Animations" mode
      _timerToReset = Timer(WidgetParams.animationDuration * timeDilation, () => setState(() => _counter++));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      key: ValueKey(_counter),
      borderRadius: widget.borderRadius,
      child: Dismissible(
        key: Key(widget.id),
        direction: widget.isEnabled ? DismissDirection.endToStart : DismissDirection.none,
        dismissThresholds: const {
          DismissDirection.endToStart: 0.33,
        },
        onUpdate: (details) {
          widget.onUpdate?.call(details);

          if (details.reached && !_isConfirmed) {
            HapticFeedback.lightImpact();
            setState(() => _isConfirmed = true);
          }

          if (!details.reached && _isConfirmed) {
            HapticFeedback.lightImpact();
            setState(() => _isConfirmed = false);
          }
        },
        onDismissed: widget.onDismissed,
        background: AnimatedContainer(
          duration: WidgetParams.animationDuration,
          curve: WidgetParams.animationCurve,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiaryContainer,
          ),
          child: Align(
            alignment: widget.iconAlignment,
            child: Padding(
              padding: EdgeInsets.only(
                top: widget.iconAlignment == Alignment.topRight ? 18.0 : 0,
                right: 18.0,
              ),
              child: SizedBox(
                width: 24.0,
                height: 24.0,
                child: Center(
                  child: Icon(
                    Icons.archive_outlined,
                    color: Theme.of(context).colorScheme.tertiary,
                    size: _isConfirmed ? 24.0 : 8.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
