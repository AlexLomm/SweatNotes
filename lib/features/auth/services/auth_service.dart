import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../router/router.dart';
import '../data/auth_repository.dart';

part 'auth_service.g.dart';

// TODO: Check sign_in_screen_controller https://github.com/bizz84/starter_architecture_flutter_firebase/blob/master/lib/src/features/authentication/presentation/sign_in/sign_in_screen_controller.dart
class AuthService {
  final AuthRepository authRepository;
  final GoRouter goRouter;
  final _defaultErrorMessage = 'Something went wrong.. Please try again later.';

  AuthService(this.authRepository, this.goRouter);

  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        return 'No user!';
      }
    } on FirebaseAuthException catch (e) {
      return e.message ?? _defaultErrorMessage;
    }

    return '';
  }

  Future<String> signUp({
    required String displayName,
    required String email,
    required String password,
  }) async {
    try {
      await authRepository.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await authRepository.updateDisplayName(displayName);
    } on FirebaseAuthException catch (e) {
      return e.message ?? _defaultErrorMessage;
    }

    return '';
  }

  Future<String> sendPasswordResetEmail(String email) async {
    try {
      await authRepository.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
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
