import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  Future<UserCredential> logIn({
    required String email,
    required String password,
  }) async {
    return FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
