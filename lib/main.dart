import 'dart:async';
import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:just_audio/just_audio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweatnotes/shared/services/audio.dart';
import 'package:timezone/data/latest_all.dart' as timezone;
import 'package:timezone/timezone.dart' as timezone;
import 'package:tuple/tuple.dart';

import 'app.dart';
import 'env.dart';
import 'firebase_options.dart';
import 'shared/services/notifications.dart';
import 'shared/services/shared_preferences.dart';

const kAppCheckEnabled = kReleaseMode;
const kCrashlyticsEnabled = kReleaseMode;
const kAnalyticsEnabled = kReleaseMode;
const kFirebaseEmulatorsEnabled = kDebugMode || kProfileMode;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // -----------------------------------
  // FIREBASE
  // -----------------------------------
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseAppCheck.instance.activate(
    appleProvider: kAppCheckEnabled ? AppleProvider.appAttestWithDeviceCheckFallback : AppleProvider.debug,
  );

  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(kCrashlyticsEnabled);
  FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(kAnalyticsEnabled);

  // catch errors that happen outside of the Flutter context
  Isolate.current.addErrorListener(RawReceivePort((pair) async {
    final List<dynamic> errorAndStacktrace = pair;
    await FirebaseCrashlytics.instance.recordError(
      errorAndStacktrace.first,
      errorAndStacktrace.last,
      fatal: true,
    );
  }).sendPort);

  // pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);

    return true;
  };

  if (kFirebaseEmulatorsEnabled) {
    try {
      FirebaseFirestore.instance.useFirestoreEmulator(Env.localIp, 8080);
      await FirebaseAuth.instance.useAuthEmulator(Env.localIp, 9099);
      await FirebaseFirestore.instance.clearPersistence();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  // -----------------------------------
  // SHARED PREFERENCES
  // -----------------------------------

  final prefs = await SharedPreferences.getInstance();

  // -----------------------------------
  // AUDIO
  // -----------------------------------

  final audioTimer0 = AudioPlayer();
  final audioTimer1 = AudioPlayer();

  await Future.wait([
    audioTimer0.setAsset('assets/audio/timer_beep_0.mp3'),
    audioTimer1.setAsset('assets/audio/timer_beep_1.mp3'),
  ]);

  // -----------------------------------
  // NOTIFICATIONS
  // -----------------------------------

  await _configureLocalTimeZone();

  // the permissions will be asked later, whenever required
  const initializationSettingsDarwin = DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );

  const initializationSettings = InitializationSettings(
    iOS: initializationSettingsDarwin,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  // -----------------------------------
  // APP
  // -----------------------------------

  runApp(
    ProviderScope(
      // override the unimplemented providers
      overrides: [
        prefsProvider.overrideWithValue(prefs),
        audioTimerProvider.overrideWithValue(Tuple2(audioTimer0, audioTimer1)),
        notificationsProvider.overrideWithValue(flutterLocalNotificationsPlugin)
      ],
      child: const App(),
    ),
  );

  // -----------------------------------
  // PACKAGE INFO
  // -----------------------------------

  // !!! must be called after runApp !!!
  final packageInfo = await PackageInfo.fromPlatform();

  FirebaseCrashlytics.instance.setCustomKey(
    'version',
    '${packageInfo.version}+${packageInfo.buildNumber}',
  );
}

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _configureLocalTimeZone() async {
  timezone.initializeTimeZones();

  final String timeZoneName = await FlutterTimezone.getLocalTimezone();

  timezone.setLocalLocation(timezone.getLocation(timeZoneName));
}
