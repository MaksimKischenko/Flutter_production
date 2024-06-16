// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_payment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeletePaymentResponse _$DeletePaymentResponseFromJson(
        Map<String, dynamic> json) =>
    DeletePaymentResponse(
      errorCode: json['ErrorCode'] as int?,
      errorText: json['ErrorText'] as String?,
    );

Map<String, dynamic> _$DeletePaymentResponseToJson(
        DeletePaymentResponse instance) =>
    <String, dynamic>{
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
    };
