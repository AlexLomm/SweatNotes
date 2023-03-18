import 'package:cloud_firestore/cloud_firestore.dart';

Timestamp? timestampFromJson(int? millisecondsSinceEpoch) {
  if (millisecondsSinceEpoch == null) return null;

  return Timestamp.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
}
