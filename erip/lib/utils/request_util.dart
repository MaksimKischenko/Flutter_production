
import 'package:bpc_nkfo/screens/screens.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'multiplatform.dart';

mixin RequestUtil {

  static const kNetworkError = 'Не удалось связаться с серверами';

  static void catchError(BuildContext context, Object obj) {
    // non-200 error goes here.
    switch (obj.runtimeType) {
      case DioException:
        //Multiplatform.showMessage(context, obj.error.toString());
        Multiplatform.showMessage<void>(
          context: context,
          title: 'Ошибка',
          message: kNetworkError
          // message: e.message
        );
        //logger.e("Got error : ${res.statusCode} -> ${res.statusMessage}");
        break;
      default:
        // Multiplatform.showMessage(
        //   context: context,
        //   title: "Ошибка",
        //   message: obj.toString()
        // );
    }
  }

  static void catchKomplatError({
    required BuildContext context,
    required int errorCode,
    required String? errorText
  }) {
    Multiplatform.showMessage<void>(
      context: context,
      title: 'Ошибка',
      message: errorText ?? 'Неизвестная ошибка'
    );
    // onKomplatErrorAction(
    //   context: context,
    //   errorCode: errorCode,
    //   errorText: errorText
    // );
  }

  static void onKomplatErrorAction({
    required BuildContext context,
    required int errorCode,
    required String errorText
  }) => Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute<void>(builder: (context) => SplashScreen()),
    (route) => false
  );
  
}