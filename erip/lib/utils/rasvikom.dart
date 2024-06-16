// ignore_for_file: always_put_required_named_parameters_first

import 'dart:convert';

import 'package:crypto/crypto.dart';

// ignore: avoid_classes_with_only_static_members
///
/// Small object which generate url with EMV-based string for payment
///
class QrErip {

  /// generate methods & data

  static const _providerUrl = 'https://pay.raschet.by/';

  static String generate(int eripCode, String account, double sum) {
    final attr32 = '0010by.raschet${_qrFromInt(eripCode, '01')}${_qrFromString(account, '10')}';
    final mainPart = '000201${_qrFromString(attr32, '32')}5303933${_attr54(sum)}5802BY${_attr59(eripCode)}6007Belarus';
    return '$_providerUrl#$mainPart${_getCheckSum(mainPart)}';
  }

  static String generateForService(int eripCode) {
    final attr32 = '0010by.raschet${_qrFromInt(eripCode, '01')}';
    final mainPart = '000201${_qrFromString(attr32, '32')}53039335802BY${_attr59(eripCode)}6007Belarus';
    return '$_providerUrl#$mainPart${_getCheckSum(mainPart)}';
  }

  static String _getCheckSum(String from) {
    final sha = sha256.convert(utf8.encode(from)).toString().replaceAll('-', '');
    return '6304${sha.substring(sha.length - 4).toUpperCase()}';
  }

  static String _attr59(int eripCode) {
    final temp = 'UNP_$eripCode';
    final len = temp.length < 10 ? '0${temp.length}' : temp.length.toString();
    return '59$len$temp';
  }

  static String _attr54(double sum) {
    final temp = sum.toString();
    final len = temp.length < 10 ? '0${temp.length}' : temp.length.toString();
    return '54$len$temp';
  }

  static String _qrFromString(String str, String code) {
    final len = str.length < 10 ? '0${str.length}' : str.length.toString();
    return '$code$len$str';
  }

  static String _qrFromInt(int i, String code) {
    final temp = i.toString();
    final len = temp.length < 10 ? '0${temp.length}' : temp.length.toString();
    return '$code$len$temp';
  }

  /// parse methods & data

  static QrEripData parse(String qrUrl) {
    Uri.parse(qrUrl);
    final data = qrUrl.replaceFirst(RegExp(r'.+\/\/[^/]+\/#'), '');
    if (!verifyCheckSum(data)) throw Exception('Неверная контрольная сумма');
    final map = <String, dynamic>{};
    var tempBlock = ParsedEmvBlock(remainingString: data);
    // parse root elements
    do {
      tempBlock = _parseEmv(tempBlock.remainingString);
      map[tempBlock.key!] = tempBlock.content;
    } while (tempBlock.remainingString.isNotEmpty);
    // parse 32 element
    tempBlock = ParsedEmvBlock(remainingString: (map['32'] as String?) ?? '');
    map.remove('32');
    map['32'] = <String, dynamic>{};
    do {
      tempBlock = _parseEmv(tempBlock.remainingString);
      map['32'][tempBlock.key] = tempBlock.content;
    } while (tempBlock.remainingString.isNotEmpty);
    // map.containsKey("54");
    return QrEripData(
      eripCode: (map['32'] as Map<String, dynamic>)['01'] as String,
      accNum: (map['32'] as Map<String, dynamic>)['10'] as String?,
      sum: map.containsKey('54')
          ? double.tryParse(map['54'] as String)
          : null
    );
  }

  static ParsedEmvBlock _parseEmv(String emvString) {
    final key = emvString.substring(0, 2);
    final len = int.parse(emvString.substring(2, 4));
    final content = emvString.substring(4, 4 + len);
    final remainingString = emvString.substring(4 + len);
    return ParsedEmvBlock(
      key: key,
      content: content,
      remainingString: remainingString
    );
  }

  static bool verifyCheckSum(String qrString) {
    final verifyString = qrString.substring(0, qrString.length - 8);
    final qrSha = qrString.substring(qrString.length - 8, qrString.length);
    return qrSha == getCheckSum(verifyString);
  }

  static String getCheckSum(String from) {
    final sha = sha256.convert(utf8.encode(from)).toString().replaceAll('-', '');
    return '6304${sha.substring(sha.length - 4).toUpperCase()}';
  }

}

class ParsedEmvBlock {
  final String? key;
  final dynamic content;
  final String remainingString;

  const ParsedEmvBlock({
    this.key,
    this.content,
    required this.remainingString
  });
}

class QrEripData {
  final String eripCode;
  final String? accNum;
  final double? sum;

  const QrEripData({
    required this.eripCode,
    this.accNum,
    this.sum
  });

  @override
  String toString() => 'QrEripData { eripCode: $eripCode, accNum: $accNum, sum: $sum }';
}

/**
 * https://pay.raschet.by/#00020132250010by.raschet01074665791520411115802BY5913UNP_6913219276007Belarus53039336304A27D
 *
 *
 * 00 - Версия стандарта
 *      len - 02
 *      val - 01
 * 32 - Информация об оплачиваемой услуге
 *      len - 25
 *      val:
 *          00 - уникальный идентификатор
 *              len - 10
 *              val - by.raschet
 *          01 - Спецификация платежной сети (код услуги ЕРИП)
 *              len - 07
 *              val - 4665791
 * 52 - MCC код производителя услуг
 *      len - 04
 *      val 1111
 * 58 - Код страны
 *      len - 02
 *      val - BY
 * 59 - Наименование произвоителя услуг латиницей
 *      len - 13
 *      val - UNP_691321927
 * 60 - Населенный пункт расположения производителя услуг
 *      len - 07
 *      val - Belarus
 * 53 - Код валюты
 *      len - 03
 *      val - 933
 * 63 - Контрольная сумма данных
 *      len - 04
 *      val - A27D
 */