// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'package:helppay_core/generated/translations.g.dart';

import 'loger.dart';

void _log(dynamic message) => Logger.helpPayLog(message, name: 'qr_erip');

class QrErip {
  static QrEripData parse(String qrUrl) {
    // url validation
    // ignore: unused_local_variable
    //final parsed = Uri.parse(qrUrl);
    final data = qrUrl.replaceFirst(RegExp(r'.+\/\/[^/]+\/#'), '');

    if (!verifyCheckSum(data))
      throw Exception(t.exceptions.qrErip.verifyCheckSum);
    final map = <String, dynamic>{};
    var tempBlock = ParsedEmvBlock(remainingString: data);
    // parse root elements
    do {
      tempBlock = _parseEmv(tempBlock.remainingString);
      map[tempBlock.key!] = tempBlock.content;
    } while (tempBlock.remainingString.isNotEmpty);
    // parse 32 element
    tempBlock = ParsedEmvBlock(remainingString: map['32'] as String);
    map.remove('32');
    map['32'] = <String, dynamic>{};
    do {
      tempBlock = _parseEmv(tempBlock.remainingString);
      map['32'][tempBlock.key] = tempBlock.content;
    } while (tempBlock.remainingString.isNotEmpty);
    _log('current erip code: ${map['32']['01']}');
    _log('current accNum: ${map['32']}');

    if(map['64'] != null) {
      _log('current recieverName: ${map['64'].toString().substring(10)}');
    }
    

    // map.containsKey("54");
    return QrEripData(
      eripCode: map['32']['01'] as String,
      accNum: map['32']['10'] as String?,
      sum: map.containsKey('54') ? double.tryParse(map['54'] as String) : null,
      recieverName: map.containsKey('64') ? map['64'].toString().substring(10) : null,
    );
  }

  static ParsedEmvBlock _parseEmv(String emvString) {
    final key = emvString.substring(0, 2);
    final len = int.parse(emvString.substring(2, 4));
    final content = emvString.substring(4, 4 + len);
    final remainingString = emvString.substring(4 + len);
    _log('Parsed emv block: #${key}: ${content}');
    return ParsedEmvBlock(
        key: key, content: content, remainingString: remainingString);
  }

  static bool verifyCheckSum(String qrString) {
    // _log('initial data - $qrString');
    final verifyString = qrString.substring(0, qrString.length - 8);
    // _log('verify string - $verifyString');
    final qrSha = qrString.substring(qrString.length - 8, qrString.length);
    // _log('qr sha - $qrSha');

    return qrSha == getCheckSum(verifyString);
  }

  static String getCheckSum(String from) {
    final sha =
        sha256.convert(utf8.encode(from)).toString().replaceAll('-', '');
    _log(' sha - $sha');
    _log(' resulting sha - 6304${sha.substring(sha.length - 4).toUpperCase()}');
    return '6304${sha.substring(sha.length - 4).toUpperCase()}';
  }

  static String bytesToHex(List<int> hash) {
    final hexString = StringBuffer();
    for (final b in hash) {
      final hex = (b & 0xff).toRadixString(16);
      if (hex.length == 1) {
        hexString.write('0');
      }
      hexString.write(hex);
    }
    return hexString.toString();
  }
}

class ParsedEmvBlock {
  String? key;
  dynamic content;
  String remainingString;

  ParsedEmvBlock({this.key, this.content, required this.remainingString});
}

class QrEripData {
  final String? eripCode;
  final String? accNum;
  final double? sum;
  final String? recieverName;

  QrEripData(
      {this.eripCode, this.recieverName, this.accNum, this.sum});

  @override
  String toString() =>
      'QrEripData { eripCode: $eripCode, accNum: $accNum, sum: $sum, recieverName: $recieverName}';

   QrEripData copyWith({
    String? eripCode,
    String? accNum,
    double? sum,
    String? recieverName,
  }) =>
    QrEripData(
       eripCode: eripCode ?? this.eripCode,
       accNum: accNum ?? this.accNum,
       sum: sum ?? this.sum,
       recieverName: recieverName ?? this.recieverName
    );
}


