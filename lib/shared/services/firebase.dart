import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase.g.dart';

@riverpod
FirebaseAuth firebaseAuth(FirebaseAuthRef ref) {
  return FirebaseAuth.instance;
}

@riverpod
FirebaseFirestore firestore(FirestoreRef ref) {
  return FirebaseFirestore.instance;
}

@riverpod
FirebaseCrashlytics crashlytics(CrashlyticsRef ref) {
  return FirebaseCrashlytics.instance;
}

@riverpod
FirebaseAnalytics analytics(AnalyticsRef ref) {
  return FirebaseAnalytics.instance;
}

final _analyticsObserver =
    FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);

@riverpod
FirebaseAnalyticsObserver analyticsObserver(AnalyticsObserverRef ref) {
  return _analyticsObserver;
}
