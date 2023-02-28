import 'package:go_router/go_router.dart';

import '../screens/auth/sign_in_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/training_block/training_block_screen.dart';
import '../services/auth_service.dart';

final _authService = AuthService();

final router = GoRouter(
  // TODO: fix
  // redirect: (context, routerState) async =>
  //     authService.user == null ? '/login' : null,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, routerState) => const HomeScreen(),
    ),
    GoRoute(
      path: '/:trainingBlockId',
      builder: (context, routerState) => TrainingBlockScreen(
        trainingBlockId:
            routerState.params['trainingBlockId'] ?? '',
      ),
    ),
    GoRoute(
      path: '/login',
      builder: (context, routerState) => SignInScreen(
        authService: _authService,
      ),
    ),
  ],
);
