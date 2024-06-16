// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'preferences_helper.dart';

class SecureStorageManager {

  static FlutterSecureStorage get storage => const FlutterSecureStorage();

  static Future<T?> read<T>(TypeStoreKey<T> typedStoreKey) async => kIsWeb
      ? await PreferencesHelper.read(typedStoreKey)
      : (await storage.read(key: typedStoreKey.key) as T?)
        ?? typedStoreKey.defaultValue;

  static Future<bool> contains(TypeStoreKey typedStoreKey) async => kIsWeb
      ? PreferencesHelper.contains(typedStoreKey)
      : storage.containsKey(key: typedStoreKey.key);

  static Future<void> write<T>(TypeStoreKey<T> typedStoreKey, T? value) async {
    if (value == null) {
      if (kIsWeb) {
        await PreferencesHelper.write(typedStoreKey, value);
      } else {
        await storage.delete(key: typedStoreKey.key);
      }

      return;
    }
    // web redirecting to preferences helper
      // unsecure!!! only for test reasons
    if (kIsWeb) return PreferencesHelper.write(typedStoreKey, value);
      
    switch (T) {
      // case int:
      //   await (await prefs).setInt(typedStoreKey.key, value as int);
      //   break;
      case String:
        await storage.write(key: typedStoreKey.key, value: value as String);
        break;
      // case double:
      //   await (await prefs).setDouble(typedStoreKey.key, value as double);
      //   break;
      // case bool:
      //   await (await prefs).setBool(typedStoreKey.key, value as bool);
      //   break;
      // case List:
      //   await (await prefs).setStringList(typedStoreKey.key, value as List<String>);
      //   break;
    }
  }

  // clear all
  static Future<void> clearAll() => storage.deleteAll();

}

class SecureStorageKeys {
  static final pincode = TypeStoreKey<String>('pincode');
  static final login = TypeStoreKey<String>('login');
  static final password = TypeStoreKey<String>('password');
}