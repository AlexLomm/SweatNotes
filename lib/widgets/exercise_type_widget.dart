import 'package:flutter/material.dart';

import '../models_client/exercise_type_client.dart';

class ExerciseTypeWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        // TODO: extract
        color: Color.fromRGBO(231, 224, 236, 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: dragHandleWidth,
            margin: const EdgeInsets.only(right: dragHandleAndLabelSpacing),
            child: const Icon(
              Icons.drag_indicator,
              color: Color.fromRGBO(103, 80, 164, 1),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 8.0),
            width: labelWidth,
            child: Text(
              exerciseType.name,
              softWrap: true,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
        ],
      ),
    );
  }
}
