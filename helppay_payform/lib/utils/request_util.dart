import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:helppay_payform_app/models/models.dart';

import 'multiplatform.dart';

// ignore: avoid_classes_with_only_static_members
class RequestUtil {
  static const kNetworkError = 'Сетевая ошибка';

  static void catchNetworkError(
      {required BuildContext context, required Object? obj}) {
    // non-200 error goes here.
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
            Multiplatform.showMessage(
              context: context,
              title: 'Произошла ошибка',
              message: kNetworkError,
              type: DialogType.error,
            );
            break;
          case DioExceptionType.badResponse:
            final message = (e.response?.data as Map?)?['message'] as String?;
            Multiplatform.showMessage(
              context: context,
              title: 'Произошла ошибка',
              message: message ?? 'Сервер не может обработать ваш запрос',
              type: DialogType.error,
            );
        }
        //Multiplatform.showMessage(context, e.error.toString());
        //logger.e("Got error : ${res.statusCode} -> ${res.statusMessage}");
        break;
      default:
        Multiplatform.showMessage(
          context: context,
          title: 'Произошла ошибка',
          message: obj?.toString() ?? 'Сервер не может обработать ваш запрос',
          type: DialogType.error,
        );
    }
  }

  // static const Map<RequestType, RequestErrors> _errorsMap = {
  //   RequestType.login: RequestErrors({
  //     // 2: 'Аккаунт не активирован'
  //   }, generalError: 'Неверный email или пароль'),
  // };

  static void catchKomplatError({
    required BuildContext context,
    required RequestType request,
    required int? errorCode,
    required String? errorText,
    bool redirectAvailable = false,
  }) {
    Multiplatform.showMessage(
      context: context,
      title: 'Произошла ошибка',
      // message: _errorsMap[request]?.error(errorCode) ?? 'Ошибка $errorCode',
      // message: _errorsMap[request]?.error(errorCode) ?? 'Неизвестная ошибка',
      message: errorText ?? 'Неизвестная ошибка',
      type: DialogType.error,
      redirectAvailable: redirectAvailable,
    );
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(builder: (context) => SplashScreen()),
    //   (route) => false
    // );
  }
}
