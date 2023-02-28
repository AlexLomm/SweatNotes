import 'package:flutter/material.dart';
import 'package:journal_flutter/models_client/exercise_type_client.dart';

class ExerciseTypeWidget extends StatelessWidget {
  static const width = 144.0;
  static const height = 80.0;

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
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: const Icon(
                    Icons.drag_indicator,
                    color: Color.fromRGBO(103, 80, 164, 1),
                  ),
                ),
                Text(
                  exerciseType.name,
                  softWrap: true,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
