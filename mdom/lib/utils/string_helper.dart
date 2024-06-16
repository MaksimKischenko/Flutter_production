import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

extension StringHelper on String {
  String toSha256() => sha256.convert(utf8.encode(this)).toString();
}

extension StringNullHelper on String? {
  bool get isNotNullorEmpty => this?.isNotEmpty ?? false;
}

String getRandString(int len) {
  final random = Random.secure();
  final values = List<int>.generate(len, (i) =>  random.nextInt(255));
  return base64UrlEncode(values);
}