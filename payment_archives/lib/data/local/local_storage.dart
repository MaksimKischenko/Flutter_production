import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';


mixin LocalStorage {

  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  static Future<Tuple2<String?, String?>> getCredentials() async =>
      Tuple2(await getString(_login), await getString(_password));

  static Future<bool> setCredentials(String login, String password) async {
    await setString(_login, login);
    return setString(_password, password);
  }

  static Future<bool> clearCredentials() async {
    await clear(_login);
    return clear(_password);
  }

  static Future<String?> getString(String key) async => (await prefs).getString(key);

  static Future<bool> setString(String key, String value) async => (await prefs).setString(key, value);

  static Future<bool> clear(String key) async => (await prefs).remove(key);

  //keys
  static const _login = 'login';
  static const _password = 'password';
}