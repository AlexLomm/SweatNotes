import 'package:flutter/material.dart';

import '../models_client/exercise_type_client.dart';
import 'exercise_type_widget.dart';

class ExerciseDayWidget extends StatelessWidget {
  static const insetSize = 24.0;
  static const width = ExerciseTypeWidget.width - insetSize;
  static const titleHeight = 56.0;
  static const spacingBetweenItems = 8.0;
  static const borderRadius = 8.0;

  final String name;
  final List<ExerciseTypeClient> exerciseTypes;

  get height =>
      exerciseTypes.length * (ExerciseTypeWidget.height + spacingBetweenItems) +
      titleHeight;

  const ExerciseDayWidget({
    Key? key,
    required this.name,
    required this.exerciseTypes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 2,
            surfaceTintColor: Theme.of(context).colorScheme.primary,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(borderRadius),
                bottomRight: Radius.circular(borderRadius),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.only(top: 18, right: 16, left: 16),
              width: width,
              height: height,
              child: Text(
                name,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: const EdgeInsets.only(top: titleHeight),
            child: Column(
              children: [
                for (final exerciseType in exerciseTypes)
                  Container(
                    key: Key(exerciseType.id),
                    margin: const EdgeInsets.only(bottom: spacingBetweenItems),
                    child: ExerciseTypeWidget(exerciseType: exerciseType),
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
