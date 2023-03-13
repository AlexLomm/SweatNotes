import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_mode_switcher.g.dart';

@riverpod
class EditModeSwitcher extends _$EditModeSwitcher {
  @override
  bool build() => false;

  void toggle() => state = !state;

  void disable() => state = false;
}
