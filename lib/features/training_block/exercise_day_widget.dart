import 'package:flutter/material.dart';

import 'data/models_client/exercise_type_client.dart';
import 'exercise_type_widget.dart';

class ExerciseDayWidget extends StatelessWidget {
  static const borderRadius = 8.0;
  static const rightInsetSize = 24.0;
  static const width = ExerciseTypeWidget.width - rightInsetSize;
  static const titleHeight = 56.0;
  static const spacingBetweenItems = 8.0;
  static const additionalBottomSpaceHeight = 28.0 - spacingBetweenItems;

  final String name;
  final List<ExerciseTypeClient> exerciseTypes;

  get height =>
      titleHeight +
      exerciseTypes.length * (ExerciseTypeWidget.height + spacingBetweenItems) +
      additionalBottomSpaceHeight;

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
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      name,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Transform.translate(
                      offset: const Offset(0, 20),
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: Material(
                          elevation: 2,
                          shape: const CircleBorder(),
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          child: IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
