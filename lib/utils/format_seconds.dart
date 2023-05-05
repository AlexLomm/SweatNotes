String formatSeconds(int? seconds) {
  final secondsSanitized = (seconds ?? 0) % 60;

  final duration = Duration(seconds: secondsSanitized);

  return duration.inSeconds.toInt().toString().padLeft(2, '0');
}
