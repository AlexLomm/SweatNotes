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
  final Future<bool?> Function(DismissDirection direction)? confirmDismiss;
  final DismissUpdateCallback? onUpdate;
  final bool isArchivable;

  const CustomDismissible({
    Key? key,
    this.isEnabled = true,
    required this.id,
    required this.borderRadius,
    required this.child,
    required this.onDismissed,
    this.confirmDismiss,
    this.onUpdate,
    this.isArchivable = false,
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
    DismissDirection direction = DismissDirection.none;

    if (widget.isEnabled && widget.isArchivable) {
      direction = DismissDirection.horizontal;
    } else if (widget.isEnabled && !widget.isArchivable) {
      direction = DismissDirection.endToStart;
    }

    return ClipRRect(
      key: ValueKey(_counter),
      borderRadius: widget.borderRadius,
      child: Dismissible(
        key: Key(widget.id),
        direction: direction,
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
        confirmDismiss: widget.confirmDismiss,
        onDismissed: widget.onDismissed,
        background: _Copy(isConfirmed: _isConfirmed),
        secondaryBackground: _Archive(isConfirmed: _isConfirmed),
        child: widget.child,
      ),
    );
  }
}

class _Copy extends StatelessWidget {
  const _Copy({
    required bool isConfirmed,
  }) : _isConfirmed = isConfirmed;

  final bool _isConfirmed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: _PaddedIcon(
          iconData: Icons.copy_outlined,
          isConfirmed: _isConfirmed,
          iconAlignment: Alignment.topLeft,
        ),
      ),
    );
  }
}

class _Archive extends StatelessWidget {
  const _Archive({
    required bool isConfirmed,
  }) : _isConfirmed = isConfirmed;

  final bool _isConfirmed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: _PaddedIcon(
          iconData: Icons.archive_outlined,
          isConfirmed: _isConfirmed,
          iconAlignment: Alignment.topRight,
        ),
      ),
    );
  }
}

class _PaddedIcon extends StatelessWidget {
  final IconData iconData;
  final bool isConfirmed;
  final Alignment iconAlignment;

  const _PaddedIcon({
    required this.iconData,
    required this.isConfirmed,
    required this.iconAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: iconAlignment == Alignment.topRight
          ? const EdgeInsets.only(top: 18.0, right: 18.0)
          : const EdgeInsets.only(top: 18.0, left: 18.0),
      child: SizedBox(
        width: 24.0,
        height: 24.0,
        child: Center(
          child: Icon(
            iconData,
            color: Theme.of(context).colorScheme.tertiary,
            size: isConfirmed ? 24.0 : 8.0,
          ),
        ),
      ),
    );
  }
}
