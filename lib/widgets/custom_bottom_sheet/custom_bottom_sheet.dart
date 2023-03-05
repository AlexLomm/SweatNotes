import 'package:flutter/material.dart';

import 'drag_handle.dart';

class CustomBottomSheet extends StatefulWidget {
  final Widget child;

  const CustomBottomSheet({super.key, required this.child});

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
        // account for keyboard height when it's open
        // see: https://stackoverflow.com/a/57515977/4241959
        padding: EdgeInsets.only(bottom: keyboardHeight),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: DragHandle(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 34),
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}
