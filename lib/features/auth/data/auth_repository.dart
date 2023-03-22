import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/services/firebase.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  final FirebaseAuth _auth;

  AuthRepository(this._auth);

  Future<void> signInWithApple() {
    return _auth.signInWithProvider(AppleAuthProvider());
  }

  Future<void> signInWithGoogle() {
    return _auth.signInWithProvider(GoogleAuthProvider());
  }

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> sendPasswordResetEmail({required String email}) {
    return _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> updateDisplayName(String displayName) {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User is unauthenticated!');
    }

    return user.updateDisplayName(displayName);
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(ref.watch(firebaseAuthProvider));
}
