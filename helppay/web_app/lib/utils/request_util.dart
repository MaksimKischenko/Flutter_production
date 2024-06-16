// ignore_for_file: avoid_classes_with_only_static_members

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:helppay_core/generated/translations.g.dart';
import 'package:helppay_core/models/models.dart';
import 'package:helppay_web_app/utils/utils.dart';

class RequestUtil {
  static String get networkError => t.exceptions.network;

  static void catchNetworkError(
      {required BuildContext context, required Object? obj}) {
    // non-200 error goes here.
    switch (obj.runtimeType) {
      case DioException:
        // final e = (obj as DioError);
        //Multiplatform.showMessage(context, e.error.toString());
        Multiplatform.showMessage(
          context: context,
          title: t.general.errorModal.title,
          message: networkError,
          type: DialogType.error,
        );
        //logger.e("Got error : ${res.statusCode} -> ${res.statusMessage}");
        break;
      default:
    }
  }

  static void catchKomplatError({
    required BuildContext context,
    required int? errorCode,
    required String? errorText,
  }) {
    Multiplatform.showMessage(
      context: context,
      title: t.general.errorModal.title,
      // message: "Ошибка $errorCode",
      message: '$errorText',
      type: DialogType.error,
    );
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(builder: (context) => SplashScreen()),
    //   (route) => false
    // );
  }
}
