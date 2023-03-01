import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../repositories/auth_repository.dart';
import '../screens/auth/sign_in_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/training_block/training_block_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  return GoRouter(
    initialLocation: '/auth/log-in',
    redirect: (context, state) {
      final isLoggedIn = authRepository.currentUser != null;

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
        path: '/:trainingBlockId',
        builder: (context, routerState) => TrainingBlockScreen(
          trainingBlockId: routerState.params['trainingBlockId'] ?? '',
        ),
      ),
    ],
  );
});
