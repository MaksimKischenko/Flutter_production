import 'package:dartx/dartx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

import 'package:web_cabinet_nkfo/models/models.dart';

// ignore: avoid_classes_with_only_static_members
class PreferencesHelper {

  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  static Future<Tuple2<String?, String?>> getCredentials() async =>
      Tuple2(await _getString(_login), await _getString(_password));

  static Future<bool> setCredentials(String login, String password) async {
    await _setString(_login, login);
    return _setString(_password, password);
  }

  static Future<bool> clearCredentials() async {
    await _clear(_login);
    return _clear(_password);
  }




  

  static Future<List<SuppliersSort>> getSupplierItems() async => (await _getStringList(_supplierItems))?.map(SuppliersSortExtension.fromDBName).sortedBy((e) => e.index).toList() ?? SuppliersSort.values;

  static Future<bool> setSupplierItems(List<SuppliersSort> items) async => _setStringList(_supplierItems, items.map((e) => e.DBName).toList());

  static Future<List<UsersSort>> getUserItems() async => (await _getStringList(_userItems))?.map(UsersSortExtension.fromDBName).sortedBy((e) => e.index).toList() ?? UsersSort.values;

  static Future<bool> setUserItems(List<UsersSort> items) async => _setStringList(_userItems, items.map((e) => e.DBName).toList());

  static Future<List<AuditSort>> getAuditItems() async => (await _getStringList(_auditItems))?.map(AuditSortExtension.fromDBName).sortedBy((e) => e.index).toList() ?? AuditSort.values;

  static Future<bool> setAuditItems(List<AuditSort> items) async => _setStringList(_auditItems, items.map((e) => e.DBName).toList());

  static Future<List<ServerMessageSort>> getServerMessageItems() async => (await _getStringList(_serverMessageItems))?.map(ServerMessageSortExtension.fromDBName).sortedBy((e) => e.index).toList() ?? ServerMessageSort.values;

  static Future<bool> setServerMessageItems(List<ServerMessageSort> items) async => _setStringList(_serverMessageItems, items.map((e) => e.DBName).toList());

  static Future<List<UnassignedTasksSort>> getUnassignedTasksItems() async => (await _getStringList(_unassignedTasksItems))?.map(UnassignedTasksSortExtension.fromDBName).sortedBy((e) => e.index).toList() ?? UnassignedTasksSort.values;

  static Future<bool> setUnassignedTasksItems(List<UnassignedTasksSort> items) async => _setStringList(_unassignedTasksItems, items.map((e) => e.DBName).toList());

  static Future<List<TasksPartSort>> getTasksPartItems() async => (await _getStringList(_tasksPart))?.map(TasksPartSortExtension.fromDBName).sortedBy((e) => e.index).toList() ?? TasksPartSort.values;

  static Future<bool> setTasksPartItems(List<TasksPartSort> items) async => _setStringList(_tasksPart, items.map((e) => e.DBName).toList());

  static Future<List<TasksPartParamSort>> getTasksPartParamItems() async => (await _getStringList(_tasksPartParam))?.map(TasksPartParamSortExtension.fromDBName).sortedBy((e) => e.index).toList() ?? TasksPartParamSort.values;

  static Future<bool> setTasksPartParamItems(List<TasksPartParamSort> items) async => _setStringList(_tasksPartParam, items.map((e) => e.DBName).toList());
  
  
  /// get/set for different types

  // static Future<bool?> _getBool(String key) async => (await prefs).getBool(key);

  // static Future<bool> _setBool(String key, bool value) async => (await prefs).setBool(key, value);

  static Future<String?> _getString(String key) async => (await prefs).getString(key);

  static Future<bool> _setString(String key, String value) async => (await prefs).setString(key, value);

  static Future<List<String>?> _getStringList(String key) async => (await prefs).getStringList(key);

  static Future<bool> _setStringList(String key, List<String> values) async => (await prefs).setStringList(key, values);

  static Future<bool> _clear(String key) async => (await prefs).remove(key);


  static Future<int?> getColorTheme(String key) async => (await prefs).getInt(key);

  static Future<bool> setColorTheme(String key, int value) async => (await prefs).setInt(key, value);


  //keys
  static const _login = 'login';
  static const _password = 'password';

  static const _supplierItems = 'supplierItems';
  static const _userItems = 'userItems';
  static const _auditItems = 'auditItems';
  static const _serverMessageItems = 'serverMessageItems';
  static const _unassignedTasksItems = 'unassignedTasksItems';
  static const _tasksPart = 'tasksPart';
  static const _tasksPartParam = 'tasksPartParam';
}