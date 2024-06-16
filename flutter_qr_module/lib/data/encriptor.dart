import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';


// void _log(dynamic message) => Logger.helpPayLog(message, name: 'encrypter');

class Criptor {
  String enctriptData({
    required String wrapperBody,
    required String requestTime,
    required String tempTerminalId,
    required String secretKeyPart,
  }) {
    // final key1 = Key.fromUtf8('$tempTerminalId$requestTime$secretKeyPart').;
    final bytes = utf8.encode('$tempTerminalId$requestTime$secretKeyPart');
    // 'KKS12023-03-13T12:29:02.3461E05F2120F03C2EDF69238D7J38C5C18B9F9B0D7C8FE9501SB1B4B6879BCF295');
    final criptedBytesRes =
        sha256.convert(bytes).bytes.take(16).toList().map<int>((element) {
      if (element > 127) {
        return element = element - 256;
      } else {
        return element;
      }
    }).toList();
    final uInt8List = Uint8List.fromList(criptedBytesRes);

    final key1 = Key(uInt8List);

    // final iv1 = IV.fromLength(16);
    final iv1 = IV.fromBase64('AAAAAAAAAAAAAAAAAAAAAA==');

    final encrypter = Encrypter(AES(
      key1,
      mode: AESMode.cbc,
      padding: 'PKCS7',
    ));

    final encrypted = encrypter.encrypt(wrapperBody, iv: iv1);

    return encrypted.base64;
  }

  String decriptData({
    required String encriptedData,
    required String requestTime,
    required String tempTerminalId,
    required String? secretKeyPart,
  }) {
// final key1 = Key.fromUtf8('$tempTerminalId$requestTime$secretKeyPart').;
    final bytes = utf8.encode('$tempTerminalId$requestTime$secretKeyPart');
    // 'KKS12023-03-13T12:29:02.3461E05F2120F03C2EDF69238D7J38C5C18B9F9B0D7C8FE9501SB1B4B6879BCF295');
    final criptedBytesRes =
        sha256.convert(bytes).bytes.take(16).toList().map<int>((element) {
      if (element > 127) {
        return element = element - 256;
      } else {
        return element;
      }
    }).toList();
    final uInt8List = Uint8List.fromList(criptedBytesRes);
    // _log('bytes = $bytes');
    // _log('criptedBytesRes = $criptedBytesRes');
    // _log('uInt8List = $uInt8List');

    final key1 = Key(uInt8List);

    // final iv1 = IV.fromLength(16);
    final iv1 = IV.fromBase64('AAAAAAAAAAAAAAAAAAAAAA==');

    final encrypter = Encrypter(
      AES(
        key1,
        mode: AESMode.cbc,
        padding: 'PKCS7',
      ),
    );

    final decrypted = encrypter.decrypt64(encriptedData, iv: iv1);

    // _log('decrypted = ${decrypted}');

    return decrypted;
  }
}
