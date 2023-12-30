import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/button_dropdown_menu.dart';
import '../settings/compact_mode_switcher.dart';
import '../settings/edit_mode_switcher.dart';
import '../settings/exercise_reactions_switcher.dart';
import '../settings/timer_switcher.dart';
import 'widget_params.dart';

class MoreOptionsMenu extends ConsumerWidget {
  const MoreOptionsMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref.watch(editModeSwitcherProvider);
    final editModeSwitcher = ref.watch(editModeSwitcherProvider.notifier);
    final isCompactMode = ref.watch(compactModeSwitcherProvider);
    final compactModeSwitcher = ref.watch(compactModeSwitcherProvider.notifier);
    final exerciseReactionsSwitcher = ref.watch(
      exerciseReactionsSwitcherProvider.notifier,
    );
    final isExerciseReactionsEnabled = ref.watch(
      exerciseReactionsSwitcherProvider,
    );
    final isTimerEnabledSwitcher = ref.watch(timerSwitcherProvider.notifier);
    final isTimerEnabled = ref.watch(timerSwitcherProvider);

    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final menuItemTheme = tt.bodyLarge?.copyWith(
      color: Theme.of(context).colorScheme.onSurface,
    );

    return AnimatedCrossFade(
      alignment: Alignment.center,
      crossFadeState:
          isEditMode ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: WidgetParams.animationDuration,
      firstCurve: WidgetParams.animationCurve,
      secondCurve: WidgetParams.animationCurve,
      firstChild: ButtonDropdownMenu(
        icon: Icons.more_vert,
        animationDuration: WidgetParams.animationDuration,
        animationCurve: WidgetParams.animationCurve,
        items: [
          ButtonDropdownMenuItem(
            onTap: () => context.push('/settings'),
            child: Text('Settings', style: menuItemTheme),
          ),
          ButtonDropdownMenuItem(
            onTap: compactModeSwitcher.toggle,
            child: _OnOffText(
              title: 'Compact mode',
              isEnabled: isCompactMode,
              textStyle: menuItemTheme,
            ),
          ),
          ButtonDropdownMenuItem(
            onTap: exerciseReactionsSwitcher.toggle,
            child: _OnOffText(
              title: 'Ex. Reactions',
              isEnabled: isExerciseReactionsEnabled,
              textStyle: menuItemTheme,
            ),
          ),
          ButtonDropdownMenuItem(
            onTap: isTimerEnabledSwitcher.toggle,
            child: _OnOffText(
              title: 'Timer',
              isEnabled: isTimerEnabled,
              textStyle: menuItemTheme,
            ),
          ),
        ],
      ),
      secondChild: IconButton(
        icon: Icon(Icons.check, color: cs.primary),
        tooltip: 'Turn off edit mode',
        splashRadius: 20,
        onPressed: editModeSwitcher.toggle,
      ),
    );
  }
}

class _OnOffText extends StatelessWidget {
  final String title;
  final bool isEnabled;
  final TextStyle? textStyle;

  const _OnOffText({
    super.key,
    required this.title,
    required this.isEnabled,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return RichText(
      softWrap: false,
      text: TextSpan(
        text: title,
        style: textStyle,
        children: [
          WidgetSpan(
            child: Container(
              margin: const EdgeInsets.only(left: 24.0),
              padding: const EdgeInsets.only(bottom: 1.0),
              child: Text(
                isEnabled ? 'On' : 'Off',
                style: tt.labelSmall?.copyWith(
                  color: isEnabled ? cs.primary : cs.onSurface,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
