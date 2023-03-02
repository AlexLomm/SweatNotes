import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences.g.dart';

// TODO: look into providing this synchronously
// @see https://docs-v2.riverpod.dev/docs/concepts/scopes#initialization-of-synchronous-provider-for-async-apis
@riverpod
Future<SharedPreferences> prefs(PrefsRef ref) {
  return SharedPreferences.getInstance();
}
