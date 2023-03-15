import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../settings/edit_mode_switcher.dart';

class IgnorePointerEditMode extends ConsumerWidget {
  final bool ignoreWhenEditMode;
  final HitTestBehavior? behavior;
  final Function()? onTap;
  final Widget child;

  const IgnorePointerEditMode({
    Key? key,
    this.ignoreWhenEditMode = false,
    this.behavior,
    this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref.watch(editModeSwitcherProvider);

    final ignoring = ignoreWhenEditMode ? isEditMode : !isEditMode;

    return IgnorePointer(
      ignoring: ignoring,
      child: onTap == null ? child : GestureDetector(behavior: behavior, onTap: onTap, child: child),
    );
  }
}
