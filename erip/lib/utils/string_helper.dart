import 'dart:convert';

import 'package:crypto/crypto.dart';

extension StringHelper on String {
  String toSha256() => sha256.convert(utf8.encode(this)).toString();

}

extension StringNullHelper on String? {
  bool get isNotNullorEmpty => this?.isNotEmpty ?? false;
}