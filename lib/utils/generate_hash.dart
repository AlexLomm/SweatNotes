import 'dart:convert';
import 'dart:math';

String generateHash({int length = 32}) {
  var random = Random.secure();
  var values = List<int>.generate(length, (i) => random.nextInt(255));

  return 'client-${base64UrlEncode(values)}';
}
