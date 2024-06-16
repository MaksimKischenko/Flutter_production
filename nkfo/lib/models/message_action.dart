import 'package:flutter/cupertino.dart';
import 'package:web_cabinet_nkfo/styles.dart';

enum MessageAction {
  view, delete, edit
}

extension MessageActionExtension on MessageAction {
  static const Map<MessageAction, String> _names = {
    MessageAction.view: 'Просмотреть',
    MessageAction.delete: 'Удалить',
    MessageAction.edit: 'Редактировать'
  };

  String get name => _names[this] ?? '';

  static const Map<MessageAction, Color> _colors = {
    MessageAction.delete: CupertinoColors.systemRed,
  };

  Color get color => _colors[this] ?? AppStyles.mainTextColor;
}