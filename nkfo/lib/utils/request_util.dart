import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:web_cabinet_nkfo/models/models.dart';

import 'multiplatform.dart';

// ignore: avoid_classes_with_only_static_members
class RequestUtil {

  static const kNetworkError = 'Сетевая ошибка';

  static void catchNetworkError({
    required BuildContext context,
    required Object? obj
  }) {
    // non-200 error goes here.
    switch (obj.runtimeType) {
      case DioError:
        final e = obj as DioError;
        switch (e.type) {
          case DioErrorType.connectTimeout:
          case DioErrorType.sendTimeout:
          case DioErrorType.receiveTimeout:
          case DioErrorType.cancel:
          case DioErrorType.other:
            Multiplatform.showMessage(
              context: context,
              title: 'Ошибка',
              message: kNetworkError,
              type: DialogType.error
            );
          break;
          case DioErrorType.response:
            final message = (e.response?.data as Map?)?['message'] as String?;
            Multiplatform.showMessage(
              context: context,
              title: 'Ошибка',
              message: message ?? 'Сервер не может обработать ваш запрос',
              type: DialogType.error
            );
        }
        //Multiplatform.showMessage(context, e.error.toString());
        //logger.e("Got error : ${res.statusCode} -> ${res.statusMessage}");
        break;
      default:
        Multiplatform.showMessage(
          context: context,
          title: 'Ошибка',
          message: obj?.toString() ?? 'Сервер не может обработать ваш запрос',
          type: DialogType.error
        );
    }
  }
}