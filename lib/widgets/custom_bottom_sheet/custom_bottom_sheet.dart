import 'package:flutter/material.dart';

import 'backdrop.dart';
import 'drag_handle.dart';

class CustomBottomSheet extends StatefulWidget {
  final double? height;
  final Widget child;

  const CustomBottomSheet({
    super.key,
    this.height,
    required this.child,
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
    return Stack(children: [
      const Positioned.fill(child: Backdrop()),
      Container(
        height: widget.height,
        margin: EdgeInsets.only(top: 80 + MediaQuery.of(context).padding.top),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: DragHandle(),
            ),
            Expanded(child: widget.child),
          ],
        ),
      ),
    ]);
  }
}
