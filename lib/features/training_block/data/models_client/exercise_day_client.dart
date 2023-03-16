import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/exercise_day.dart';
import 'exercise_type_client.dart';

part 'exercise_day_client.freezed.dart';

@freezed
class ExerciseDayClient with _$ExerciseDayClient {
  const ExerciseDayClient._();

  Map<String, int> get _exerciseTypesNewOrdering => exerciseTypes
      //
      .asMap()
      .map((key, value) => MapEntry(value.dbModel.id, key));

  const factory ExerciseDayClient({
    required ExerciseDay dbModel,
    required String name,
    required List<ExerciseTypeClient> exerciseTypes,
  }) = _ExerciseDayClient;

  ExerciseDay toDbModel() => dbModel.copyWith(
        name: name,
        exerciseTypesOrdering: _exerciseTypesNewOrdering,
      );
}
