import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journal_flutter/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'env.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (kReleaseMode) {
    // Pass all uncaught "fatal" errors from the framework to Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);

      return true;
    };
  }

  if (kDebugMode || kProfileMode) {
    try {
      FirebaseFirestore.instance.useFirestoreEmulator(Env.localIp, 8080);
      await FirebaseAuth.instance.useAuthEmulator(Env.localIp, 9099);
      await FirebaseFirestore.instance.clearPersistence();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  // get the instance of shared preferences
  final prefs = await SharedPreferences.getInstance();

  return runApp(
    ProviderScope(
      // override the unimplemented providers
      overrides: [
        prefsProvider.overrideWithValue(prefs),
      ],
      child: const App(),
    ),
  );
}
