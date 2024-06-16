// ignore_for_file: avoid_classes_with_only_static_members

import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {

  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  static Future<T?> read<T>(TypeStoreKey<T> typedStoreKey) async => ((await prefs).get(typedStoreKey.key) as T?)
      ?? typedStoreKey.defaultValue;

  static Future<bool> contains(TypeStoreKey typedStoreKey) async => (await prefs).containsKey(typedStoreKey.key);

  static Future<void> write<T>(TypeStoreKey<T> typedStoreKey, T? value) async {
    if (value == null) {
      await (await prefs).remove(typedStoreKey.key);

      return;
    }
    switch (T) {
      case int:
        await (await prefs).setInt(typedStoreKey.key, value as int);
        break;
      case String:
        await (await prefs).setString(typedStoreKey.key, value as String);
        break;
      case double:
        await (await prefs).setDouble(typedStoreKey.key, value as double);
        break;
      case bool:
        await (await prefs).setBool(typedStoreKey.key, value as bool);
        break;
      case List:
        await (await prefs).setStringList(typedStoreKey.key, value as List<String>);
        break;
    }
  }
}

class PrefsKeys {
  // client settings
  static final terminalId = TypeStoreKey<String>('terminalId', defaultValue: 'SHOP_TABLET');
  static final pan = TypeStoreKey<String>('pan', defaultValue: '01-003'); //1
  static final typePan = TypeStoreKey<String>('typePan', defaultValue: 'EMKP'); //ACCOUNT_HOLDER
  /// base url
  static final resourcesUrl = TypeStoreKey<String>('resourcesUrl', defaultValue: 'http://192.168.249.58:8085'); //http://192.168.244.104:3007
  static final servletName = TypeStoreKey<String>('servletName', defaultValue: 'komplat_shop');
  // dio
  static final connectionTimeout = TypeStoreKey<int>('connectionTimeout', defaultValue: 30);
  static final receiveTimeout = TypeStoreKey<int>('receiveTimeout', defaultValue: 30);
  /// modal
  static final modalActivityTimeout = TypeStoreKey<int>('modalActivityTimeout', defaultValue: 30);
  /// session close timer
  static final waitingTimeout = TypeStoreKey<int>('waitingTimeout', defaultValue: 600);
  /// checkConnection
  static final monitoringTimeout = TypeStoreKey<int>('monitoringTimeout', defaultValue: 900);
}

/// Обьект типизированный ключ используемый в key-value хранилищах для более удобной работы с ними
/// [T] - тип хранимого значения
/// [key] - строковый ключ
/// [defaultValue] - значение по умолчанию
///
/// Хранилище может ограничивать типизацию [T], обычно оно ограничивается стандартными типами: [int], [double], [String], [bool].
class TypeStoreKey<T> {
  final type = T;

  final String key;
  final T? defaultValue;
  TypeStoreKey(
    this.key,{
    this.defaultValue
  });

  @override
  String toString() => 'TypeStoreKey(key: $key, defaultValue: $defaultValue)';
}