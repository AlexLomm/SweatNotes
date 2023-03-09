import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:journal_flutter/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../firebase.dart';
import '../features/auth/sign_up_screen.dart';
import '../features/auth/reset_password_screen.dart';
import '../features/auth/reset_password_finished_screen.dart';
import '../features/auth/sign_in_screen.dart';
import '../features/home/home_screen.dart';
import '../features/training_block/training_block_screen.dart';

part 'router.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final firebaseAuth = ref.read(firebaseAuthProvider);
  final prefs = ref.read(prefsProvider);
  final routeObserver = ref.read(routeObserverProvider);

  return GoRouter(
    observers: [routeObserver],
    initialLocation: prefs.getString('initialLocation') ?? '/auth/log-in',
    redirect: (context, state) {
      final isLoggedIn = firebaseAuth.currentUser != null;

      // Always check state.subloc before returning a non-null route
      // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/redirection.dart#L78
      final isOnOneOfAuthPages = state.subloc.startsWith('/auth');

      if (isLoggedIn && isOnOneOfAuthPages) {
        return '/';
      }

      if (!isLoggedIn && !isOnOneOfAuthPages) {
        return '/auth/log-in';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, routerState) => const HomeScreen(),
      ),
      GoRoute(
        path: '/auth/log-in',
        builder: (context, routerState) => const SignInScreen(),
      ),
      GoRoute(
        path: '/auth/sign-up',
        builder: (context, routerState) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/auth/reset-password',
        builder: (context, routerState) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: '/auth/reset-password-finished',
        builder: (context, routerState) => const ResetPasswordFinishedScreen(),
      ),
      GoRoute(
        path: '/:trainingBlockId',
        builder: (context, routerState) => TrainingBlockScreen(
          trainingBlockId: routerState.params['trainingBlockId'] ?? '',
        ),
      ),
    ],
  );
}

@riverpod
RouteObserver<ModalRoute<void>> routeObserver(RouteObserverRef ref) {
  return RouteObserver<ModalRoute<void>>();
}
