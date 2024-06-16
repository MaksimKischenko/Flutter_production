// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomEditUserRequestWrapper _$MdomEditUserRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomEditUserRequestWrapper(
      MdomEditUserRequest.fromJson(json['UserRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomEditUserRequestWrapperToJson(
        MdomEditUserRequestWrapper instance) =>
    <String, dynamic>{
      'UserRequest': instance.userRequest,
    };

MdomEditUserRequest _$MdomEditUserRequestFromJson(Map<String, dynamic> json) =>
    MdomEditUserRequest(
      requestType: json['RequestType'] as String? ?? 'EditUser',
      terminalId: json['TerminalId'] as String,
      version: json['Version'] as String,
      token: json['Token'] as String,
      lang: json['Lang'] as String?,
      params: json['Params'] == null
          ? null
          : MdomRequestParams.fromJson(json['Params'] as Map<String, dynamic>),
      needChangePassword: json['NeedChangePassword'] == null
          ? null
          : EditUserRequestNeedChangePassword.fromJson(
              json['NeedChangePassword'] as Map<String, dynamic>),
      products: json['Products'] == null
          ? null
          : MdomEditUserRequestProducts.fromJson(
              json['Products'] as Map<String, dynamic>),
      terminals: json['Terminals'] == null
          ? null
          : MdomEditUserRequestTerminals.fromJson(
              json['Terminals'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomEditUserRequestToJson(MdomEditUserRequest instance) {
  final val = <String, dynamic>{
    'RequestType': instance.requestType,
    'TerminalId': instance.terminalId,
    'Version': instance.version,
    'Token': instance.token,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Lang', instance.lang);
  writeNotNull('Params', instance.params);
  writeNotNull('NeedChangePassword', instance.needChangePassword);
  writeNotNull('Products', instance.products);
  writeNotNull('Terminals', instance.terminals);
  return val;
}

EditUserRequestNeedChangePassword _$EditUserRequestNeedChangePasswordFromJson(
        Map<String, dynamic> json) =>
    EditUserRequestNeedChangePassword(
      evalue: json['evalue'] as int,
      oldPassword: json['@OldPassword'] as String,
      newPassword: json['@NewPassword'] as String,
    );

Map<String, dynamic> _$EditUserRequestNeedChangePasswordToJson(
        EditUserRequestNeedChangePassword instance) =>
    <String, dynamic>{
      'evalue': instance.evalue,
      '@OldPassword': instance.oldPassword,
      '@NewPassword': instance.newPassword,
    };

MdomEditUserRequestProducts _$MdomEditUserRequestProductsFromJson(
        Map<String, dynamic> json) =>
    MdomEditUserRequestProducts(
      isDel: json['isDel'] == null
          ? null
          : MdomEditUserRequestProductsIsDel.fromJson(
              json['isDel'] as Map<String, dynamic>),
      isEdit: json['isEdit'] == null
          ? null
          : MdomEditUserRequestProductsIsEdit.fromJson(
              json['isEdit'] as Map<String, dynamic>),
      isAdd: json['isAdd'] == null
          ? null
          : MdomEditUserRequestProductsIsAdd.fromJson(
              json['isAdd'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomEditUserRequestProductsToJson(
        MdomEditUserRequestProducts instance) =>
    <String, dynamic>{
      'isDel': instance.isDel,
      'isEdit': instance.isEdit,
      'isAdd': instance.isAdd,
    };

MdomEditUserRequestProductsIsDel _$MdomEditUserRequestProductsIsDelFromJson(
        Map<String, dynamic> json) =>
    MdomEditUserRequestProductsIsDel(
      pan: (json['PAN'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MdomEditUserRequestProductsIsDelToJson(
        MdomEditUserRequestProductsIsDel instance) =>
    <String, dynamic>{
      'PAN': instance.pan,
    };

MdomEditUserRequestProductsIsEdit _$MdomEditUserRequestProductsIsEditFromJson(
        Map<String, dynamic> json) =>
    MdomEditUserRequestProductsIsEdit(
      pan: (json['PAN'] as List<dynamic>)
          .map((e) => e == null
              ? null
              : MdomEditUserRequestAccountsIsEditPan.fromJson(
                  e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MdomEditUserRequestProductsIsEditToJson(
        MdomEditUserRequestProductsIsEdit instance) =>
    <String, dynamic>{
      'PAN': instance.pan,
    };

MdomEditUserRequestAccountsIsEditPan
    _$MdomEditUserRequestAccountsIsEditPanFromJson(Map<String, dynamic> json) =>
        MdomEditUserRequestAccountsIsEditPan(
          value: json['@Value'] as String,
          params: MdomRequestParams.fromJson(
              json['Params'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MdomEditUserRequestAccountsIsEditPanToJson(
        MdomEditUserRequestAccountsIsEditPan instance) =>
    <String, dynamic>{
      '@Value': instance.value,
      'Params': instance.params,
    };

MdomEditUserRequestProductsIsAdd _$MdomEditUserRequestProductsIsAddFromJson(
        Map<String, dynamic> json) =>
    MdomEditUserRequestProductsIsAdd(
      products: (json['Product'] as List<dynamic>)
          .map((e) => MdomEditUserRequestAccountsIsAddProduct.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MdomEditUserRequestProductsIsAddToJson(
        MdomEditUserRequestProductsIsAdd instance) =>
    <String, dynamic>{
      'Product': instance.products,
    };

MdomEditUserRequestAccountsIsAddProduct
    _$MdomEditUserRequestAccountsIsAddProductFromJson(
            Map<String, dynamic> json) =>
        MdomEditUserRequestAccountsIsAddProduct(
          params: MdomRequestParams.fromJson(
              json['Params'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MdomEditUserRequestAccountsIsAddProductToJson(
        MdomEditUserRequestAccountsIsAddProduct instance) =>
    <String, dynamic>{
      'Params': instance.params,
    };

MdomEditUserRequestTerminals _$MdomEditUserRequestTerminalsFromJson(
        Map<String, dynamic> json) =>
    MdomEditUserRequestTerminals(
      isDel: json['isDel'] == null
          ? null
          : MdomEditUserRequestTerminalsIsDel.fromJson(
              json['isDel'] as Map<String, dynamic>),
      isEdit: json['isEdit'] == null
          ? null
          : MdomEditUserRequestTerminalsIsEdit.fromJson(
              json['isEdit'] as Map<String, dynamic>),
      isAdd: json['isAdd'] == null
          ? null
          : MdomEditUserRequestTerminalsIsAdd.fromJson(
              json['isAdd'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomEditUserRequestTerminalsToJson(
        MdomEditUserRequestTerminals instance) =>
    <String, dynamic>{
      'isDel': instance.isDel,
      'isEdit': instance.isEdit,
      'isAdd': instance.isAdd,
    };

MdomEditUserRequestTerminalsIsDel _$MdomEditUserRequestTerminalsIsDelFromJson(
        Map<String, dynamic> json) =>
    MdomEditUserRequestTerminalsIsDel(
      terminalKKS: (json['TerminalKKS'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$MdomEditUserRequestTerminalsIsDelToJson(
        MdomEditUserRequestTerminalsIsDel instance) =>
    <String, dynamic>{
      'TerminalKKS': instance.terminalKKS,
    };

MdomEditUserRequestTerminalsIsEdit _$MdomEditUserRequestTerminalsIsEditFromJson(
        Map<String, dynamic> json) =>
    MdomEditUserRequestTerminalsIsEdit(
      terminalKKS: (json['TerminalKKS'] as List<dynamic>)
          .map((e) => MdomEditUserRequestTerminalsIsEditTerminalKKS.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MdomEditUserRequestTerminalsIsEditToJson(
        MdomEditUserRequestTerminalsIsEdit instance) =>
    <String, dynamic>{
      'TerminalKKS': instance.terminalKKS,
    };

MdomEditUserRequestTerminalsIsEditTerminalKKS
    _$MdomEditUserRequestTerminalsIsEditTerminalKKSFromJson(
            Map<String, dynamic> json) =>
        MdomEditUserRequestTerminalsIsEditTerminalKKS(
          value: json['@Value'] as String,
          params: (json['Params'] as List<dynamic>)
              .map((e) => MdomRequestParams.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$MdomEditUserRequestTerminalsIsEditTerminalKKSToJson(
        MdomEditUserRequestTerminalsIsEditTerminalKKS instance) =>
    <String, dynamic>{
      '@Value': instance.value,
      'Params': instance.params,
    };

MdomEditUserRequestTerminalsIsAdd _$MdomEditUserRequestTerminalsIsAddFromJson(
        Map<String, dynamic> json) =>
    MdomEditUserRequestTerminalsIsAdd(
      terminalKKS: (json['TerminalKKS'] as List<dynamic>)
          .map((e) => MdomEditUserRequestTerminalsIsAddTerminalKKS.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MdomEditUserRequestTerminalsIsAddToJson(
        MdomEditUserRequestTerminalsIsAdd instance) =>
    <String, dynamic>{
      'TerminalKKS': instance.terminalKKS,
    };

MdomEditUserRequestTerminalsIsAddTerminalKKS
    _$MdomEditUserRequestTerminalsIsAddTerminalKKSFromJson(
            Map<String, dynamic> json) =>
        MdomEditUserRequestTerminalsIsAddTerminalKKS(
          value: json['@Value'] as String,
          params: (json['Params'] as List<dynamic>)
              .map((e) => MdomRequestParams.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$MdomEditUserRequestTerminalsIsAddTerminalKKSToJson(
        MdomEditUserRequestTerminalsIsAddTerminalKKS instance) =>
    <String, dynamic>{
      '@Value': instance.value,
      'Params': instance.params,
    };
