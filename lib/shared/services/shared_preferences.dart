import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences.g.dart';

@riverpod
SharedPreferences prefs(PrefsRef ref) {
  // going to be provided through ProviderScope override
  return throw UnimplementedError();
}
