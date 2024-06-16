import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

abstract interface class Failure  {
  final String message;
  const Failure(this.message);
}

class DioFailure implements Failure {
  final DioException error;

  DioFailure({
    required this.error,
  });
  
  @override
  String get message {
    log('${error.type}');
    if(error.response?.statusCode == 400) {
      return (error.response?.data is String)? error.response?.data as String : (error.response?.data as Map?)?['message'] as String? ?? '';
    } else if(error.response?.statusCode == null) {
      if(error.type == DioExceptionType.connectionTimeout) {
        return 'Истекло время ожидание соединения';
      }
      if(error.type != DioExceptionType.unknown) {
        return json.decode(error.message ?? '')['error_text'] as String;
      } else {
        return 'Ошибка связи с сервером';
      }
    } else {
      return 'Неизвестная ошибка';
    }
  }
}

class WebSocketFailure implements Failure {
  final Exception error;

  WebSocketFailure({
    required this.error,
  });
  
  @override
  String get message => error.toString();
}


class FormReportFailure implements Failure {
  final Exception error;

  FormReportFailure({
    required this.error,
  });
  
  @override
  String get message => error.toString();
}