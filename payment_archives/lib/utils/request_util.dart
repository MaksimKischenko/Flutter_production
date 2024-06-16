
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/utils/utils.dart';


 mixin RequestUtil {

  static const kNetworkError = 'Сетевая ошибка';

  static void catchNetworkError({
    required BuildContext context,
    required Object? obj,
    bool isStringErrorType = false
  }) {
    switch (obj.runtimeType) {
      case DioException:
        final e = obj as DioException;
        switch (e.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.sendTimeout:
          case DioExceptionType.receiveTimeout:
          case DioExceptionType.cancel:
          case DioExceptionType.badCertificate:
          case DioExceptionType.connectionError:
          case DioExceptionType.unknown:
            DialogPlatform.showMessage(
              context: context,
              title: 'Ошибка',
              message: kNetworkError,
              type: DialogType.error
            );
          break;
          case DioExceptionType.badResponse:
            final message = (e.response?.data is String)? e.response?.data as String : (e.response?.data as Map?)?['message'] as String?;
            DialogPlatform.showMessage(
              context: context,
              title: 'Ошибка',
              message: message ?? 'Сервер не может обработать ваш запрос',
              type: DialogType.error
            );
        }
        break;     
      default:
        DialogPlatform.showMessage(
          context: context,
          title: 'Ошибка',
          message: obj.toString(),
          type: DialogType.error
        );
    }
  }
}


