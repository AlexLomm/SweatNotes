import 'package:sweatnotes/utils/format_seconds.dart';

import 'format_minutes.dart';

String formatSecondsIntoTimerString(int? seconds) {
  return '${formatMinutes(seconds)}:${formatSeconds(seconds)}';
}
