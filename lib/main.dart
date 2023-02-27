import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:journal_flutter/screens/auth/sign_in_screen.dart';
import 'package:journal_flutter/screens/home/home_screen.dart';
import 'package:journal_flutter/screens/training_block/training_block_screen.dart';
import 'package:journal_flutter/services/auth_service.dart';
import 'package:journal_flutter/theme.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    try {
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // TODO: DI with Riverpod
  final authService = AuthService();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Journal',
      theme: theme,
      scrollBehavior: AppScrollBehavior(),
      routerConfig: _router(),
    );
  }

  GoRouter _router() {
    return GoRouter(
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
            trainingBlockId: routerState.params['trainingBlockId'] ?? '',
          ),
        ),
        GoRoute(
          path: '/login',
          builder: (context, routerState) => SignInScreen(
            authService: authService,
          ),
        ),
      ],
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
