import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/training_block/widget_params.dart';

class Reaction extends ConsumerWidget {
  final bool isSelected;
  final bool isCancelState;
  final int? value;

  Reaction({
    super.key,
    this.isSelected = false,
    this.isCancelState = false,
    required this.value,
  }) : assert(value == null || [-5, 0, 5].contains(value));

  // account for the issues regarding centering of emojis on iOS
  // see: https://github.com/flutter/flutter/issues/119623
  get _emojiByValue {
    if (isCancelState) return const EmojiCancel();

    switch (value) {
      case -5:
        return const EmojiBad();
      case 0:
        return const EmojiNeutral();
      case 5:
        return const EmojiGood();
      default:
        return const EmojiNone();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetParams = ref.watch(widgetParamsProvider);

    return Container(
      width: widgetParams.reactionCircleSize,
      height: widgetParams.reactionCircleSize,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected
              ? Theme.of(context).colorScheme.primary.withOpacity(0.67)
              : Theme.of(context).colorScheme.onSurface.withOpacity(0.32),
          width: 1.0,
        ),
      ),
      child: Center(
        child: _emojiByValue,
      ),
    );
  }
}

class EmojiGood extends ConsumerWidget {
  const EmojiGood({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetParams = ref.watch(widgetParamsProvider);

    return Transform.translate(
      offset: widgetParams.isCompactMode
          ? const Offset(1.35, 0.0)
          : const Offset(0.5, -0.5),
      child: Text(
        '🤩',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: widgetParams.isCompactMode ? 18.0 : 22.0,
            ),
      ),
    );
  }
}

class EmojiNeutral extends ConsumerWidget {
  const EmojiNeutral({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetParams = ref.watch(widgetParamsProvider);

    return Transform.translate(
      offset: widgetParams.isCompactMode
          ? const Offset(1.4, -0.75)
          : const Offset(0.5, -1.0),
      child: Text(
        '😐',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: widgetParams.isCompactMode ? 18.0 : 22.0,
            ),
      ),
    );
  }
}

class EmojiBad extends ConsumerWidget {
  const EmojiBad({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetParams = ref.watch(widgetParamsProvider);

    return Transform.translate(
      offset: widgetParams.isCompactMode
          ? const Offset(1.0, -0.5)
          : const Offset(0.0, -0.5),
      child: Text(
        '🤮',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: widgetParams.isCompactMode ? 18.0 : 22.0,
            ),
      ),
    );
  }
}

class EmojiNone extends ConsumerWidget {
  const EmojiNone({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetParams = ref.watch(widgetParamsProvider);

    return Transform.translate(
      offset: widgetParams.isCompactMode
          ? const Offset(2.0, -1.0)
          : const Offset(0.4, -1.3),
      child: Text(
        '🫥',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: widgetParams.isCompactMode ? 16.0 : 22.0,
            ),
      ),
    );
  }
}

class EmojiCancel extends ConsumerWidget {
  const EmojiCancel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetParams = ref.watch(widgetParamsProvider);

    return Transform.translate(
      offset: widgetParams.isCompactMode
          ? const Offset(0.0, 0.0)
          : const Offset(0.0, 0.0),
      child: Text(
        '✕',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: widgetParams.isCompactMode ? 16.0 : 22.0,
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
    );
  }
}
