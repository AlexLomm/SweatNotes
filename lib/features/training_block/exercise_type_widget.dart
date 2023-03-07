import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journal_flutter/features/training_block/services/exercise_types_service.dart';
import 'package:journal_flutter/widgets/text_editor_multi_line.dart';

import '../../widgets/custom_bottom_sheet/custom_bottom_sheet.dart';
import 'data/models_client/exercise_type_client.dart';

class ExerciseTypeWidget extends ConsumerWidget {
  static const width = 144.0;
  static const height = 80.0;
  static const dragHandleWidth = 24.0;
  static const dragHandleAndLabelSpacing = 8.0;
  static const labelWidth = width - dragHandleWidth - dragHandleAndLabelSpacing;

  final ExerciseTypeClient exerciseType;

  const ExerciseTypeWidget({
    Key? key,
    required this.exerciseType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercisesService = ref.watch(exerciseTypesServiceProvider);

    return Material(
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: SizedBox(
        width: width,
        height: height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: dragHandleWidth,
              margin: const EdgeInsets.only(right: dragHandleAndLabelSpacing),
              child: Icon(
                Icons.drag_indicator,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            GestureDetector(
              onTap: () => CustomBottomSheet(
                title: 'Edit exercise type',
                child: TextEditorMultiLine(
                  value: exerciseType.name,
                  onSubmitted: (String text) {
                    // TODO: review api
                    exercisesService.setName(
                      exerciseTypeClient: exerciseType,
                      name: text,
                    );

                    Navigator.of(context).pop();
                  },
                ),
              ).show(context),
              child: Container(
                padding: const EdgeInsets.only(right: 8.0),
                width: labelWidth,
                height: double.infinity,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    exerciseType.name,
                    softWrap: true,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
