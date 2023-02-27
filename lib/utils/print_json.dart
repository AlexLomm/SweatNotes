import 'dart:convert';

import 'package:flutter/foundation.dart';

const JsonEncoder _encoder = JsonEncoder.withIndent('  ');

void printJson(Object json) {
  var prettyString = _encoder.convert(json);

  prettyString.split('\n').forEach((element) => debugPrint(element));
}
