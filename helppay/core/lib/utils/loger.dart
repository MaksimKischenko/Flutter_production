// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:developer' as developer;

class Logger {
  static void helpPayLog(
    dynamic message, {
    String name = '',
    dynamic error,
    StackTrace? stacktrace,
    int level = 84,
  }) {
    developer.log(
      message is String ? message : message?.toString() ?? 'null',
      time: DateTime.now(),
      level: level,
      stackTrace: stacktrace,
      name: name,
    );
  }
}
