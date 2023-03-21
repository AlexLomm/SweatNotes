import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/services/firebase.dart';

part 'user.g.dart';

@riverpod
Stream<User?> user(UserRef ref) async* {
  final firebaseAuth = ref.watch(firebaseAuthProvider);

  yield* firebaseAuth.userChanges();
}
