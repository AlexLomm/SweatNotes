import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweatnotes/features/settings/show_archived_exercise_types_switcher.dart';
import 'package:sweatnotes/features/training_block/widget_params.dart';

import '../settings/edit_mode_switcher.dart';

class ToggleEditModeButton extends ConsumerWidget {
  const ToggleEditModeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref.watch(editModeSwitcherProvider);
    final editModeSwitcher = ref.watch(editModeSwitcherProvider.notifier);
    final showArchived = ref.watch(showArchivedExerciseTypesSwitcherProvider);
    final showArchivedNotifier = ref.watch(
      showArchivedExerciseTypesSwitcherProvider.notifier,
    );

    return AnimatedCrossFade(
      alignment: Alignment.center,
      crossFadeState:
          isEditMode ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: WidgetParams.animationDuration,
      firstCurve: WidgetParams.animationCurve,
      secondCurve: WidgetParams.animationCurve,
      firstChild: AnimatedOpacity(
        opacity: isEditMode ? 0 : 1,
        duration: WidgetParams.animationDuration,
        curve: WidgetParams.animationCurve,
        child: IconButton(
          icon: Icon(
            Icons.edit_outlined,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          tooltip: 'Turn on edit mode',
          splashRadius: 20,
          onPressed: () => isEditMode ? null : editModeSwitcher.toggle(),
        ),
      ),
      secondChild: IconButton(
        tooltip: showArchived
            ? "Don't show archived exercises"
            : 'Show archived exercises',
        splashRadius: 20,
        icon: AnimatedCrossFade(
          alignment: Alignment.center,
          crossFadeState: showArchived
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: WidgetParams.animationDuration,
          firstCurve: WidgetParams.animationCurve,
          secondCurve: WidgetParams.animationCurve,
          firstChild: const Icon(Icons.unarchive_outlined),
          secondChild: Icon(Icons.cancel_outlined,
              color: Theme.of(context).colorScheme.tertiary),
        ),
        onPressed: showArchivedNotifier.toggle,
      ),
    );
  }
}
