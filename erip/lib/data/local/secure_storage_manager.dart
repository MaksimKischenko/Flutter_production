import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tuple/tuple.dart';

// ignore: avoid_classes_with_only_static_members
class SecureStorageManager {

  static const storage = FlutterSecureStorage();

  static Future<Tuple2<String?, String?>> getCredentials() async {
    final login = await storage.read(key: _login);
    final password = await storage.read(key: _password);
    return Tuple2(login, password);
  }

  static Future deleteCredentials() async {
    await storage.delete(key: _login);
    return storage.delete(key: _password);
  }

  static Future writeCredentials(String login, String password) async {
    await storage.write(key: _login, value: login);
    return storage.write(key: _password, value: password);
  }



  static Future<String?> getPinCode() => storage.read(key: _pincode);

  static Future deletePinCode() => storage.delete(key: _pincode);

  static Future writePinCode(String pin) => storage.write(key: _pincode, value: pin);

  // static Future<String> getLogin() async {
  //   String token = await storage.read(key: "login");
  //   return token;
  // }

  // static Future deleteLogin() {
  //   return storage.delete(key: "login");
  // }

  // static Future writeLogin(String login) {
  //   return storage.write(key: "login", value: login);
  // }

  // static Future<String> getPassword() async {
  //   String token = await storage.read(key: "password");
  //   return token;
  // }

  // static Future deletePassword() {
  //   return storage.delete(key: "password");
  // }

  // static Future writePassword(String password) {
  //   return storage.write(key: "password", value: password);
  // }

  //keys
  static const _pincode = 'pincode';
  static const _login = 'login';
  static const _password = 'password';


  // clear all
  static Future<void> clearAll() => storage.deleteAll();

}