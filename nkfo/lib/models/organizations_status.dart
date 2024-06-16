import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum OrganizationStatus {
  enabled, disabled
}

extension OrganizationStatusExtension on OrganizationStatus {
  static const Map<OrganizationStatus, Color> _colors = {
    OrganizationStatus.disabled: CupertinoColors.systemRed,
    OrganizationStatus.enabled: CupertinoColors.systemGreen
  };

  Color get color => _colors[this] ?? Colors.grey;

  static const Map<OrganizationStatus, String> _texts = {
    OrganizationStatus.enabled: 'Подключен',
    OrganizationStatus.disabled: 'Отключен'
  };

  String get text => _texts[this] ?? 'Неизвестно';
}