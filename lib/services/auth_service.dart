import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/auth_repository.dart';
import '../router/router.dart';

part 'auth_service.g.dart';

// TODO: Check sign_in_screen_controller https://github.com/bizz84/starter_architecture_flutter_firebase/blob/master/lib/src/features/authentication/presentation/sign_in/sign_in_screen_controller.dart
class AuthService {
  User? user;

  final AuthRepository authRepository;
  final GoRouter goRouter;

  AuthService(this.authRepository, this.goRouter);

  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await authRepository.signInWithEmailAndPassword(
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

  Future<void> signOut() async {
    try {
      await authRepository.signOut();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
    } finally {
      goRouter.go('/auth/log-in');
    }
  }
}

@riverpod
AuthService authService(AuthServiceRef ref) {
  return AuthService(
    ref.watch(authRepositoryProvider),
    ref.watch(goRouterProvider),
  );
}
