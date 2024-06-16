import 'package:shared_preferences/shared_preferences.dart';

// ignore: avoid_classes_with_only_static_members
class PreferencesHelper {
  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  static Future<String?> getToken() => _getString(_token);

  static Future<bool> setToken(String token) => _setString(_token, token);

  static Future<bool> clearToken() => _clear(_token);

  static Future<String?> getMode() => _getString(_mode);

  static Future<bool> setMode(String mode) => _setString(_mode, mode);

  static Future<bool> clearMode() => _clear(_mode);

  /// get/set for different types

  // static Future<bool?> _getBool(String key) async => (await prefs).getBool(key);

  // static Future<bool> _setBool(String key, bool value) async => (await prefs).setBool(key, value);

  static Future<String?> _getString(String key) async =>
      (await prefs).getString(key);

  static Future<bool> _setString(String key, String value) async =>
      (await prefs).setString(key, value);

  static Future<bool> _clear(String key) async => (await prefs).remove(key);

  //keys
  static const _token = 'token';
  static const _mode = 'mode';
}
