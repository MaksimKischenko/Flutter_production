// ignore_for_file: avoid_classes_with_only_static_members

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay_core/generated/translations.g.dart';
import 'package:helppay_core/models/models.dart';

class RequestUtil {

  static final networkError = t.exceptions.network;

  static void catchNetworkError({
    required BuildContext context,
    required Object? obj,
    bool isStringErrorType = false
  }) {
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
              title: 'Ошибка',
              message: networkError,
              type: DialogType.error
            );
          break;
          case DioExceptionType.badResponse:
            final message = (e.response?.data is String)? e.response?.data as String : (e.response?.data as Map?)?['message'] as String?;
            //final message = isStringErrorType? e.response?.data as String: (e.response?.data as Map?)?['message'] as String?;
            //final stringMessage = e.response?.data as String; 
            Multiplatform.showMessage(
              context: context,
              title: 'Ошибка',
              message: message ?? 'Сервер не может обработать ваш запрос',
              type: DialogType.error
            );
        }
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

  static Future<void> catchKomplatError({
    required BuildContext context,
    required int? errorCode,
    required String? errorText,
  }) async {
    await Multiplatform.showMessage(
      context: context,
      title: t.general.errorModal.title,
      // message: "Ошибка $errorCode",
      message: '$errorText',
      type: DialogType.error,
    );
  }
}


