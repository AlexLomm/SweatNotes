import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/settings/widgets/account_screen.dart';
import '../features/settings/widgets/settings_screen.dart';
import '../features/settings/widgets/theme_screen.dart';
import '../main.dart';
import '../shared/services/firebase.dart';
import '../features/auth/sign_up_screen.dart';
import '../features/auth/reset_password_screen.dart';
import '../features/auth/reset_password_finished_screen.dart';
import '../features/auth/sign_in_screen.dart';
import '../features/home/home_screen.dart';
import '../features/training_block/training_block_screen.dart';
import '../shared/services/shared_preferences.dart';

part 'router.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final firebaseAuth = ref.read(firebaseAuthProvider);
  final prefs = ref.read(prefsProvider);
  final routeObserver = ref.read(routeObserverProvider);
  final analyticsObserver = ref.read(analyticsObserverProvider);

  return GoRouter(
    observers: kAnalyticsEnabled ? [routeObserver, analyticsObserver] : [routeObserver],
    initialLocation: prefs.getString('initialLocation') ?? '/auth',
    redirect: (context, state) {
      final isLoggedIn = firebaseAuth.currentUser != null;

      // Always check state.subloc before returning a non-null route
      // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/redirection.dart#L78
      final isOnOneOfAuthPages = state.subloc.startsWith('/auth');

      if (isLoggedIn && isOnOneOfAuthPages) {
        return '/';
      }

      if (!isLoggedIn && !isOnOneOfAuthPages) {
        return '/auth';
      }

      return null;
    },
    routes: [
      GoRoute(
        name: 'log-in',
        path: '/auth',
        builder: (_, __) => const LogInScreen(),
        routes: [
          GoRoute(
            name: 'sign-up',
            path: 'sign-up',
            builder: (_, __) => const SignUpScreen(),
          ),
          GoRoute(
            name: 'reset-password',
            path: 'reset-password',
            builder: (_, __) => const ResetPasswordScreen(),
          ),
          GoRoute(
            name: 'reset-password-finished',
            path: 'reset-password-finished',
            builder: (_, __) => const ResetPasswordFinishedScreen(),
          ),
        ],
      ),
      GoRoute(
        name: 'home',
        path: '/',
        builder: (_, __) => const HomeScreen(),
        routes: [
          GoRoute(
            name: 'settings',
            path: 'settings',
            builder: (_, __) => const SettingsScreen(),
            routes: [
              GoRoute(
                name: 'account',
                path: 'account',
                builder: (_, __) => const AccountScreen(),
              ),
              GoRoute(
                name: 'theme',
                path: 'theme',
                builder: (_, __) => const ThemeScreen(),
              ),
            ],
          ),
          GoRoute(
            name: 'training-block',
            path: ':trainingBlockId',
            builder: (_, routerState) => TrainingBlockScreen(
              trainingBlockId: routerState.params['trainingBlockId'] ?? '',
            ),
          ),
        ],
      ),
    ],
  );
}

// route observer is instantiated outside of the provider
// to make sure that the same instance is provided every time
// @see https://stackoverflow.com/a/68545914/4241959
final _routeObserver = RouteObserver<ModalRoute<void>>();

@riverpod
RouteObserver<ModalRoute<void>> routeObserver(RouteObserverRef ref) {
  return _routeObserver;
}
