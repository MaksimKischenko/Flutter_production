import 'package:shared_preferences/shared_preferences.dart';

// ignore: avoid_classes_with_only_static_members
class PreferencesHelper {

  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  static Future<bool> getAuthWithBiometrics() async => (await _getBool(_authWithBiometrics)) ?? false;

  // ignore: avoid_positional_boolean_parameters
  static Future<bool> setAuthWithBiometrics(bool value) => _setBool(_authWithBiometrics, value);


  static Future<bool> getFirstLoad() async => (await _getBool(_firstLoad)) ?? true;

  // ignore: avoid_positional_boolean_parameters
  static Future<bool> setFirstLoad(bool value) => _setBool(_firstLoad, value);

  /// get/set for different types

  static Future<bool?> _getBool(String key) async => (await prefs).getBool(key);

  static Future<bool> _setBool(String key, bool value) async => (await prefs).setBool(key, value);

  //keys
  static const _authWithBiometrics = 'authwithbiometrics';
  static const _firstLoad = 'firstLoad'; 

  // clear all
  static Future<bool> clearAll() async => (await prefs).clear();
}