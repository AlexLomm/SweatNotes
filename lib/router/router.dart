import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sweatnotes/features/home/training_block_create_update_screen.dart';
import 'package:sweatnotes/features/training_block/data/models_client/exercise_day_client.dart';
import 'package:sweatnotes/features/training_block/exercise_day_create_update_screen.dart';
import 'package:tuple/tuple.dart';

import '../features/settings/widgets/account_screen.dart';
import '../features/settings/widgets/settings_screen.dart';
import '../features/settings/widgets/theme_screen.dart';
import '../features/training_block/data/models_client/training_block_client.dart';
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

class RouteNames {
  static const home = 'home';
  static const logIn = 'log-in';
  static const signUp = 'sign-up';
  static const resetPassword = 'reset-password';
  static const resetPasswordFinished = 'reset-password-finished';
  static const settings = 'settings';
  static const account = 'account';
  static const theme = 'theme';
  static const trainingBlock = 'training-block';
  static const trainingBlockCreateUpdate = 'training-block-create-update';
  static const exerciseDayCreateUpdate = 'exercise-day-create-update';
}

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
        name: RouteNames.logIn,
        path: '/auth',
        builder: (_, __) => const LogInScreen(),
        routes: [
          GoRoute(
            name: RouteNames.signUp,
            path: 'sign-up',
            builder: (_, __) => const SignUpScreen(),
          ),
          GoRoute(
            name: RouteNames.resetPassword,
            path: 'reset-password',
            builder: (_, __) => const ResetPasswordScreen(),
          ),
          GoRoute(
            name: RouteNames.resetPasswordFinished,
            path: 'reset-password-finished',
            builder: (_, __) => const ResetPasswordFinishedScreen(),
          ),
        ],
      ),
      GoRoute(
        name: RouteNames.home,
        path: '/',
        builder: (_, __) => const HomeScreen(),
        routes: [
          GoRoute(
            name: RouteNames.settings,
            path: 'settings',
            builder: (_, __) => const SettingsScreen(),
            routes: [
              GoRoute(
                name: RouteNames.account,
                path: 'account',
                builder: (_, __) => const AccountScreen(),
              ),
              GoRoute(
                name: RouteNames.theme,
                path: 'theme',
                builder: (_, __) => const ThemeScreen(),
              ),
            ],
          ),
          GoRoute(
            name: RouteNames.trainingBlockCreateUpdate,
            path: 'training-block-create-update',
            builder: (_, routerState) {
              final trainingBlock =
                  routerState.extra is TrainingBlockClient ? routerState.extra as TrainingBlockClient : null;

              return TrainingBlockCreateUpdateScreen(trainingBlock: trainingBlock);
            },
          ),
          GoRoute(
            name: RouteNames.exerciseDayCreateUpdate,
            path: 'exercise-day-create-update',
            builder: (_, routerState) {
              assert(routerState.extra is Tuple2<String, ExerciseDayClient?>);

              final tuple = routerState.extra as Tuple2<String, ExerciseDayClient?>;

              return ExerciseDayCreateUpdateScreen(
                trainingBlockId: tuple.item1,
                exerciseDay: tuple.item2,
              );
            },
          ),
          GoRoute(
            name: RouteNames.trainingBlock,
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
