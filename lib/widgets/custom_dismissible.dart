import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDismissible extends StatefulWidget {
  final bool isEnabled;
  final String id;
  final BorderRadius borderRadius;
  final Widget child;
  final DismissDirectionCallback? onDismissed;

  const CustomDismissible({
    Key? key,
    this.isEnabled = true,
    required this.id,
    required this.borderRadius,
    required this.child,
    required this.onDismissed,
  }) : super(key: key);

  @override
  State<CustomDismissible> createState() => _CustomDismissibleState();
}

class _CustomDismissibleState extends State<CustomDismissible> {
  bool _isConfirmed = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius,
      child: Dismissible(
        key: Key(widget.id),
        direction: widget.isEnabled ? DismissDirection.endToStart : DismissDirection.none,
        dismissThresholds: const {
          DismissDirection.endToStart: 0.33,
        },
        onUpdate: (direction) {
          if (direction.reached && !_isConfirmed) {
            HapticFeedback.lightImpact();
            setState(() => _isConfirmed = true);
          }

          if (!direction.reached && _isConfirmed) {
            HapticFeedback.lightImpact();
            setState(() => _isConfirmed = false);
          }
        },
        onDismissed: widget.onDismissed,
        background: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiaryContainer,
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: SizedBox(
                width: 24.0,
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
