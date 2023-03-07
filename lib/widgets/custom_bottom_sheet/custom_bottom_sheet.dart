import 'package:flutter/material.dart';

import 'drag_handle.dart';

class CustomBottomSheet extends StatefulWidget {
  static const double headerHeight = 56.0;
  static const double bottomPadding = 34.0;
  static const double allSpacing = headerHeight + bottomPadding;

  final String title;
  final Widget child;
  final double height;

  const CustomBottomSheet({
    super.key,
    required this.child,
    this.height = 326.0,
    this.title = '',
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();

  Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => this,
    );
  }
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  late Widget child = widget.child;

  @override
  void didUpdateWidget(covariant CustomBottomSheet oldWidget) {
    if (widget.child.hashCode != child.hashCode) {
      setState(() => child = widget.child);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Material(
      elevation: 3,
      color: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Container(
        height: widget.height + keyboardHeight,
        // account for keyboard height when it's open
        // see: https://stackoverflow.com/a/57515977/4241959
        padding: EdgeInsets.only(bottom: keyboardHeight),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Transform.translate(
                offset: const Offset(0, -20.0),
                child: const DragHandle(),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  SizedBox(
                    height: CustomBottomSheet.headerHeight,
                    child: Center(
                      child: Text(
                        widget.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: widget.child,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
