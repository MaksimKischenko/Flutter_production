import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum UsersBlockStatus {
  all, locked, unlocked
}

extension UsersBlockStatusExtension on UsersBlockStatus {
  static const Map<UsersBlockStatus, String> _names = {
    UsersBlockStatus.all: 'Все',
    UsersBlockStatus.locked: 'Заблокирован',
    UsersBlockStatus.unlocked: 'Разблокирован'
  };

  String get name => _names[this] ?? 'Неизвестно';

  static const Map<UsersBlockStatus, Color> _colors = {
    UsersBlockStatus.locked: CupertinoColors.systemRed,
    UsersBlockStatus.unlocked: CupertinoColors.systemGreen
  };

  Color get color => _colors[this] ?? Colors.grey;

  static final Map<UsersBlockStatus, bool> _mapToBool = {
    UsersBlockStatus.locked: true,
    UsersBlockStatus.unlocked: false
  };

  bool? get boolean => _mapToBool[this];
}