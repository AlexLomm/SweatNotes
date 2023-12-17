import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import '../../../../utils/generate_hash.dart';
import '../models/exercise_day.dart';
import 'exercise_type_client.dart';

part 'exercise_day_client.freezed.dart';

@Freezed(equal: false)
class ExerciseDayClient with _$ExerciseDayClient {
  const ExerciseDayClient._();

  Map<String, int> get _exerciseTypesNewOrdering => exerciseTypes
      //
      .asMap()
      .map((key, value) => MapEntry(value.dbModel.id, key));

  const factory ExerciseDayClient({
    required ExerciseDay dbModel,
    required List<DateTime> dates,
    Timestamp? archivedAt,
    required String name,
    required List<ExerciseTypeClient> exerciseTypes,
  }) = _ExerciseDayClient;

  factory ExerciseDayClient.empty() {
    final dbModel = ExerciseDay(
      pseudoId: generateHash(),
      name: '',
      weekDay: null,
      archivedAt: null,
      exerciseTypesOrdering: {},
    );

    return ExerciseDayClient(
      dbModel: dbModel,
      name: dbModel.name,
      dates: [],
      archivedAt: dbModel.archivedAt,
      exerciseTypes: [],
    );
  }

  ExerciseDay toDbModel() {
    return dbModel.copyWith(
      name: name,
      archivedAt: archivedAt,
      exerciseTypesOrdering: _exerciseTypesNewOrdering,
    );
  }

  String getFormattedDateAt(int index) {
    if (areDatesEmpty) return '...';

    assert(
      index >= 0 && index < dates.length,
      'Invalid index $index out of range [0, ${dates.length})',
    );

    return DateFormat('EEE, dd MMM yyyy').format(dates[index]);
  }

  bool get areDatesEmpty => dates.isEmpty;

  ExerciseDayClient reorderExerciseType({
    required int from,
    required int to,
  }) {
    if (from == to) return this;

    if (from < 0 || from >= exerciseTypes.length) throw Exception('Invalid from index $from');

    if (to < 0 || to >= exerciseTypes.length) throw Exception('Invalid to index $to');

    final newList = [...exerciseTypes];

    if (from < to) {
      for (var i = from; i < to; i++) {
        newList[i] = newList[i + 1];
      }
    } else {
      for (var i = from; i > to; i--) {
        newList[i] = newList[i - 1];
      }
    }

    newList[to] = exerciseTypes[from];

    return copyWith(exerciseTypes: newList);
  }

  ExerciseTypeClient getExerciseTypeById(String id) {
    return exerciseTypes.firstWhere((e) => e.dbModel.id == id);
  }

  ExerciseDayClient removeExerciseTypeById(String id) {
    return copyWith(exerciseTypes: exerciseTypes.where((e) => e.dbModel.id != id).toList());
  }

  ExerciseDayClient prependExerciseType(ExerciseTypeClient exerciseTypeClient) {
    return copyWith(
      exerciseTypes: [exerciseTypeClient, ...exerciseTypes],
    );
  }

  ExerciseDayClient appendExerciseType(ExerciseTypeClient exerciseTypeClient) {
    return copyWith(
      exerciseTypes: [...exerciseTypes, exerciseTypeClient],
    );
  }

  ExerciseDayClient archive(bool archive) {
    return copyWith(archivedAt: archive ? Timestamp.now() : null);
  }

  ExerciseDayClient getWithOnlyPersonalRecords() {
    return copyWith(
      exerciseTypes: exerciseTypes.map((e) => e.getWithOnlyPersonalRecords()).toList(),
    );
  }

  ExerciseDayClient getWithExerciseTypesArchived(bool archived) {
    return copyWith(
      exerciseTypes: exerciseTypes.where((e) => archived ? true : e.archivedAt == null).toList(),
    );
  }
}
