import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../app.dart';
import '../../../shared/services/firebase.dart';
import '../../../router/router.dart';
import '../data/auth_repository.dart';

part 'auth_service.g.dart';

class AuthService {
  final AuthRepository authRepository;
  final GoRouter goRouter;
  final ScaffoldMessengerState? messenger;
  final FirebaseCrashlytics crashlytics;
  final FirebaseAnalytics analytics;

  final _defaultErrorMessage = 'Something went wrong.. Please try again later.';

  AuthService(
    this.authRepository,
    this.goRouter,
    this.messenger,
    this.crashlytics,
    this.analytics,
  );

  Future<void> signInWithApple() async {
    try {
      await authRepository.signInWithApple();

      analytics.logLogin(loginMethod: 'apple');

      goRouter.goNamed(RouteNames.home);
    } on FirebaseAuthException catch (e) {
      _showError(e.message);
    } catch (e) {
      // "reason" will append the word "thrown" in the Crashlytics console
      crashlytics.recordError(e, StackTrace.current, reason: 'when logging in with apple');

      _showError(e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await authRepository.signInWithGoogle();

      analytics.logLogin(loginMethod: 'google');

      goRouter.goNamed(RouteNames.home);
    } on FirebaseAuthException catch (e) {
      _showError(e.message);
    } catch (e) {
      // "reason" will append the word "thrown" in the Crashlytics console
      crashlytics.recordError(e, StackTrace.current, reason: 'when logging in with google');

      _showError(e.toString());
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      analytics.logLogin(loginMethod: 'email');

      goRouter.goNamed(RouteNames.home);
    } on FirebaseAuthException catch (e) {
      _showError(e.message);
    } catch (e) {
      // "reason" will append the word "thrown" in the Crashlytics console
      crashlytics.recordError(e, StackTrace.current, reason: 'when logging in with email and password');

      _showError(e.toString());
    }
  }

  Future<void> signUp({
    required String displayName,
    required String email,
    required String password,
  }) async {
    try {
      await authRepository.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // update the display name after the user
      // has been created but don't wait for it
      authRepository.updateDisplayName(displayName);

      analytics.logSignUp(signUpMethod: 'email');

      goRouter.goNamed(RouteNames.home);
    } on FirebaseAuthException catch (e) {
      _showError(e.message);
    } catch (e) {
      // "reason" will append the word "thrown" in the Crashlytics console
      crashlytics.recordError(e, StackTrace.current, reason: 'when signing up with email, password and display name');

      _showError(e.toString());
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await authRepository.sendPasswordResetEmail(email: email);

      analytics.logEvent(name: 'reset_password_email_sent');

      goRouter.goNamed(RouteNames.resetPasswordFinished);
    } on FirebaseAuthException catch (e) {
      _showError(e.message);
    } catch (e) {
      crashlytics.recordError(e, StackTrace.current, reason: 'when sending password reset email');

      _showError(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await authRepository.signOut();

      analytics.logEvent(name: 'sign_out');

      goRouter.goNamed(RouteNames.logIn);
    } on FirebaseAuthException catch (e) {
      _showError(e.message);
    } catch (e) {
      crashlytics.recordError(e, StackTrace.current, reason: 'when logging out');

      _showError(e.toString());
    }
  }

  Future<void> deleteAccount() async {
    try {
      await authRepository.deleteAccount();

      analytics.logEvent(name: 'delete_account');

      goRouter.goNamed(RouteNames.logIn);

      messenger?.showSnackBar(const SnackBar(content: Text('Account deleted successfully!')));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        await signOut();

        messenger?.showSnackBar(
          const SnackBar(content: Text('For your security please log in and try deactivating again!')),
        );

        return;
      }

      _showError(e.message);
    } catch (e) {
      crashlytics.recordError(e, StackTrace.current, reason: 'when deactivating account');

      _showError(e.toString());
    }
  }

  Future<void> updateDisplayName(String displayName) async {
    try {
      await authRepository.updateDisplayName(displayName);

      analytics.logEvent(name: 'update_display_name');

      goRouter.goNamed(RouteNames.settings);

      messenger?.clearSnackBars();
      messenger?.showSnackBar(const SnackBar(content: Text('Display name updated successfully!')));
    } on FirebaseAuthException catch (e) {
      _showError(e.message);
    } catch (e) {
      crashlytics.recordError(e, StackTrace.current, reason: 'when updating display name');

      _showError(e.toString());
    }
  }

  void _showError(String? error) {
    error ??= _defaultErrorMessage;

    messenger?.clearSnackBars();
    messenger?.showSnackBar(SnackBar(content: Text(error)));
  }
}

@riverpod
AuthService authService(AuthServiceRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final goRouter = ref.watch(goRouterProvider);
  final messenger = ref.watch(messengerProvider);
  final crashlytics = ref.watch(crashlyticsProvider);
  final analytics = ref.watch(analyticsProvider);

  return AuthService(
    authRepository,
    goRouter,
    messenger,
    crashlytics,
    analytics,
  );
}
