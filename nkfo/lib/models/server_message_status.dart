import 'package:flutter/cupertino.dart';

enum ServerMessageStatus {
  all, draft, pending, sended
}

extension ServerMessageStatusExtension on ServerMessageStatus {
  
  static const Map<ServerMessageStatus, Color> _colors = {
    ServerMessageStatus.draft: CupertinoColors.black,
    ServerMessageStatus.pending: CupertinoColors.systemYellow,
    ServerMessageStatus.sended: CupertinoColors.systemGreen,
  };

  Color get color => _colors[this] ?? CupertinoColors.black;

  static const Map<ServerMessageStatus, String> _names = {
    ServerMessageStatus.all: 'Все',
    ServerMessageStatus.draft: 'Черновик',
    ServerMessageStatus.pending: 'Ожидание отправки',
    ServerMessageStatus.sended: 'Отправлено'
  };

  String? get name => _names[this] ?? 'Неизвестно';


  static final Map<ServerMessageStatus, int> _mapToValue = {
    ServerMessageStatus.draft: 1,
    ServerMessageStatus.pending: 2,
    ServerMessageStatus.sended: 3,
  };

  int? get value => _mapToValue[this];

  
  static final Map <ServerMessageStatus, String> _maptoNames = {
    ServerMessageStatus.draft: 'Черновик',
    ServerMessageStatus.pending: 'Ожидает отправки',
    ServerMessageStatus.sended: 'Отправлено'
  };


  static final Map<int, ServerMessageStatus> _fromInt = {
    1: ServerMessageStatus.draft,
    2: ServerMessageStatus.pending,
    3: ServerMessageStatus.sended,
  };

  static ServerMessageStatus fromInt(int? value) => _fromInt[value] ?? ServerMessageStatus.all;

  String? get naming =>_maptoNames[this];

}