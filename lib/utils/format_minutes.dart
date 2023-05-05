String formatMinutes(int? seconds) {
  final secondsSanitized = seconds ?? 0;

  final duration = Duration(seconds: secondsSanitized);

  return duration.inMinutes.toInt().toString().padLeft(2, '0');
}
