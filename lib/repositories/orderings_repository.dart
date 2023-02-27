import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/ordering.dart';

class OrderingsRepository {
  List<DocumentReference<Ordering>> getOrderingRefsByIds({
    required List<String> ids,
  }) {
    return ids.map(
      (id) {
        return FirebaseFirestore.instance
            .collection('orderings')
            .doc(id)
            .withConverter(
              fromFirestore: (doc, _) {
                final dataWithoutId = doc.data();

                if (dataWithoutId == null) {
                  return Ordering.fromJson({
                    'id': 'non-existent',
                    'userId': FirebaseAuth.instance.currentUser?.uid,
                    'ordering': {},
                  });
                }

                final data = {'id': doc.id, ...dataWithoutId};

                return Ordering.fromJson(data);
              },
              toFirestore: (exercise, _) => exercise.toJson(),
            );
      },
    ).toList();
  }

  Future<List<Ordering>> fetchOrderingsByIds({
    required List<String> ids,
  }) async {
    final orderingRefs = getOrderingRefsByIds(ids: ids);

    if (orderingRefs.isEmpty) {
      return [];
    }

    final snapshots = await Future.wait(
      orderingRefs.map((ordering) => ordering.get()),
    );

    return snapshots.map((snapshot) => snapshot.data()!).toList();
  }
}
