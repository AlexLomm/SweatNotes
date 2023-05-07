import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tuple/tuple.dart';

part 'audio.g.dart';

@riverpod
Tuple2<AudioPlayer, AudioPlayer> audioTimer(AudioTimerRef ref) {
  // going to be provided through ProviderScope override
  return throw UnimplementedError();
}
