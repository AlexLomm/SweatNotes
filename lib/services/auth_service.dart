import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:journal_flutter/repositories/auth_repository.dart';

class AuthService {
  User? user;

  // TODO: DI with Riverpod
  final AuthRepository _authRepository = AuthRepository();

  Future<String> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _authRepository.logIn(
        email: 'alex.lomia@gmail.com',
        password: 'Password#1',
      );

      if (credential.user == null) {
        return 'No user!';
      } else {
        user = credential.user;
      }
    } on FirebaseAuthException catch (e) {
      return e.message ?? '';
    }

    return '';
  }
}
