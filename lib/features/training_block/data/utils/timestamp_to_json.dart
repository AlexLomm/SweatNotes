import 'package:cloud_firestore/cloud_firestore.dart';

int? timestampToJson(Timestamp? timestamp) {
  if (timestamp == null) return null;

  return timestamp.millisecondsSinceEpoch;
}
