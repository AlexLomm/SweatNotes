import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme_switcher.dart';

class ThemeSwitcherWidget extends ConsumerWidget {
  const ThemeSwitcherWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeSwitcher = ref.watch(themeSwitcherProvider.notifier);
    final theme = ref.watch(themeSwitcherProvider);

    const double borderRadius = 32.0;

    return Center(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: Theme.of(context).colorScheme.outline),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CapsuleButton(
              label: 'Light',
              borderRadius: borderRadius,
              isSelected: theme == ThemeMode.light,
              placement: CapsuleButtonPlacement.left,
              onPressed: () => themeSwitcher.setThemeMode(ThemeMode.light),
            ),
            CapsuleButton(
              label: 'Dark',
              borderRadius: borderRadius,
              isSelected: theme == ThemeMode.dark,
              placement: CapsuleButtonPlacement.center,
              onPressed: () => themeSwitcher.setThemeMode(ThemeMode.dark),
            ),
            CapsuleButton(
              label: 'System',
              borderRadius: borderRadius,
              isSelected: theme == ThemeMode.system,
              placement: CapsuleButtonPlacement.right,
              onPressed: () => themeSwitcher.setThemeMode(ThemeMode.system),
            )
          ],
        ),
      ),
    );
  }
}

enum CapsuleButtonPlacement {
  left,
  right,
  center,
}

class CapsuleButton extends StatelessWidget {
  final bool isSelected;
  final String label;
  final CapsuleButtonPlacement placement;
  final VoidCallback onPressed;
  final double borderRadius;

  bool get _isLeft => placement == CapsuleButtonPlacement.left;

  bool get _isRight => placement == CapsuleButtonPlacement.right;

  const CapsuleButton({
    super.key,
    required this.isSelected,
    required this.label,
    required this.placement,
    required this.onPressed,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadiusObject = BorderRadius.only(
      topLeft: Radius.circular(_isLeft ? borderRadius : 0),
      topRight: Radius.circular(_isRight ? borderRadius : 0),
      bottomLeft: Radius.circular(_isLeft ? borderRadius : 0),
      bottomRight: Radius.circular(_isRight ? borderRadius : 0),
    );

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 120,
        height: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          shape: BoxShape.rectangle,
          borderRadius: borderRadiusObject,
        ),
        child: Material(
          color: isSelected
              ? Theme.of(context).colorScheme.outline.withOpacity(0.32)
              : Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadiusObject,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isSelected)
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.check,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    size: 16,
                  ),
                ),
              Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
