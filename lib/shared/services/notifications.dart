import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notifications.g.dart';

@riverpod
FlutterLocalNotificationsPlugin notifications(NotificationsRef ref) {
  // going to be provided through ProviderScope override
  return throw UnimplementedError();
}
