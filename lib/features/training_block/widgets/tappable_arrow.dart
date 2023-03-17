import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widget_params.dart';

enum TappableArrowDirection {
  up,
  down,
}

class TappableArrow extends ConsumerWidget {
  final TappableArrowDirection direction;
  final bool isDisabled;
  final void Function() onTap;

  const TappableArrow({
    Key? key,
    required this.direction,
    required this.isDisabled,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetParams = ref.watch(widgetParamsProvider);

    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      // even when disabled, the gesture detector should still prevent
      // the user from interacting with the underlying widget
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 24.0,
        width: widgetParams.exerciseTypeDragHandleWidth,
        color: Colors.white.withOpacity(0.0001),
        child: AnimatedOpacity(
          opacity: isDisabled ? 0.32 : 1.0,
          duration: WidgetParams.animationDuration,
          curve: WidgetParams.animationCurve,
          child: Icon(
            direction == TappableArrowDirection.up ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
