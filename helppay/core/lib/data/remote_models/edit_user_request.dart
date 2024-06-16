import 'package:helppay_core/data/remote_models/mdom_base_models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_user_request.g.dart';

@JsonSerializable()
class MdomEditUserRequestWrapper {

  @JsonKey(name: 'UserRequest')
  final MdomEditUserRequest userRequest;

  MdomEditUserRequestWrapper(this.userRequest);

  factory MdomEditUserRequestWrapper.fromJson(Map<String, dynamic> json) => _$MdomEditUserRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomEditUserRequestWrapperToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class MdomEditUserRequest {

  @JsonKey(name: 'RequestType')
  final String requestType;

  @JsonKey(name: 'TerminalId')
  final String terminalId;

  @JsonKey(name: 'Version')
  final String version;

  @JsonKey(name: 'Token')
  final String token;

  @JsonKey(name: 'Lang')
  final String? lang;

  @JsonKey(name: 'Params')
  final MdomRequestParams? params;

  @JsonKey(name: 'NeedChangePassword')
  final EditUserRequestNeedChangePassword? needChangePassword;

  @JsonKey(name: 'Products')
  final MdomEditUserRequestProducts? products;

  @JsonKey(name: 'Terminals')
  final MdomEditUserRequestTerminals? terminals;

  MdomEditUserRequest({
    this.requestType = 'EditUser',
    required this.terminalId,
    required this.version,
    required this.token,
    this.lang,
    this.params,
    this.needChangePassword,
    this.products,
    this.terminals
  });

  factory MdomEditUserRequest.fromJson(Map<String, dynamic> json) => _$MdomEditUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MdomEditUserRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class EditUserRequestNeedChangePassword {
  
  @JsonKey(name: 'evalue')
  final int evalue;

  @JsonKey(name: '@OldPassword')
  final String oldPassword;

  @JsonKey(name: '@NewPassword')
  final String newPassword;


  EditUserRequestNeedChangePassword({
    required this.evalue,
    required this.oldPassword,
    required this.newPassword
  });

  factory EditUserRequestNeedChangePassword.fromJson(Map<String, dynamic> json) => _$EditUserRequestNeedChangePasswordFromJson(json);

  Map<String, dynamic> toJson() => _$EditUserRequestNeedChangePasswordToJson(this);

}

@JsonSerializable()
class MdomEditUserRequestProducts {

  @JsonKey(name: 'isDel')
  final MdomEditUserRequestProductsIsDel? isDel;

  @JsonKey(name: 'isEdit')
  final MdomEditUserRequestProductsIsEdit? isEdit;

  @JsonKey(name: 'isAdd')
  final MdomEditUserRequestProductsIsAdd? isAdd;

  MdomEditUserRequestProducts({
    this.isDel,
    this.isEdit,
    this.isAdd
  });

  factory MdomEditUserRequestProducts.fromJson(Map<String, dynamic> json) => _$MdomEditUserRequestProductsFromJson(json);

  Map<String, dynamic> toJson() => _$MdomEditUserRequestProductsToJson(this);
  
}

@JsonSerializable()
class MdomEditUserRequestProductsIsDel {

  @JsonKey(name: 'PAN')
  final List<String> pan;

  MdomEditUserRequestProductsIsDel({
    required this.pan,
  });

  factory MdomEditUserRequestProductsIsDel.fromJson(Map<String, dynamic> json) => _$MdomEditUserRequestProductsIsDelFromJson(json);

  Map<String, dynamic> toJson() => _$MdomEditUserRequestProductsIsDelToJson(this);
  
}

@JsonSerializable()
class MdomEditUserRequestProductsIsEdit {

  @JsonKey(name: 'PAN')
  final List<MdomEditUserRequestAccountsIsEditPan?> pan;

  MdomEditUserRequestProductsIsEdit({
    required this.pan,
  });

  factory MdomEditUserRequestProductsIsEdit.fromJson(Map<String, dynamic> json) => _$MdomEditUserRequestProductsIsEditFromJson(json);

  Map<String, dynamic> toJson() => _$MdomEditUserRequestProductsIsEditToJson(this);
  
}

@JsonSerializable()
class MdomEditUserRequestAccountsIsEditPan {

  @JsonKey(name: '@Value')
  final String value;

  @JsonKey(name: 'Params')
  final MdomRequestParams params;

  MdomEditUserRequestAccountsIsEditPan({
    required this.value,
    required this.params
  });

  factory MdomEditUserRequestAccountsIsEditPan.fromJson(Map<String, dynamic> json) => _$MdomEditUserRequestAccountsIsEditPanFromJson(json);

  Map<String, dynamic> toJson() => _$MdomEditUserRequestAccountsIsEditPanToJson(this);
  
}

@JsonSerializable()
class MdomEditUserRequestProductsIsAdd {

  @JsonKey(name: 'Product')
  final List<MdomEditUserRequestAccountsIsAddProduct> products;

  MdomEditUserRequestProductsIsAdd({
    required this.products,
  });

  factory MdomEditUserRequestProductsIsAdd.fromJson(Map<String, dynamic> json) => _$MdomEditUserRequestProductsIsAddFromJson(json);

  Map<String, dynamic> toJson() => _$MdomEditUserRequestProductsIsAddToJson(this);
  
}

@JsonSerializable()
class MdomEditUserRequestAccountsIsAddProduct {

  @JsonKey(name: 'Params')
  final MdomRequestParams params;

  MdomEditUserRequestAccountsIsAddProduct({
    required this.params,
  });

  factory MdomEditUserRequestAccountsIsAddProduct.fromJson(Map<String, dynamic> json) => _$MdomEditUserRequestAccountsIsAddProductFromJson(json);

  Map<String, dynamic> toJson() => _$MdomEditUserRequestAccountsIsAddProductToJson(this);
  
}

@JsonSerializable()
class MdomEditUserRequestTerminals {

  @JsonKey(name: 'isDel')
  final MdomEditUserRequestTerminalsIsDel? isDel;

  @JsonKey(name: 'isEdit')
  final MdomEditUserRequestTerminalsIsEdit? isEdit;

  @JsonKey(name: 'isAdd')
  final MdomEditUserRequestTerminalsIsAdd? isAdd;

  MdomEditUserRequestTerminals({
    this.isDel,
    this.isEdit,
    this.isAdd
  });

  factory MdomEditUserRequestTerminals.fromJson(Map<String, dynamic> json) => _$MdomEditUserRequestTerminalsFromJson(json);

  Map<String, dynamic> toJson() => _$MdomEditUserRequestTerminalsToJson(this);
  
}

@JsonSerializable()
class MdomEditUserRequestTerminalsIsDel {

  @JsonKey(name: 'TerminalKKS')
  final List<String> terminalKKS;

  MdomEditUserRequestTerminalsIsDel({
    required this.terminalKKS,
  });

  factory MdomEditUserRequestTerminalsIsDel.fromJson(Map<String, dynamic> json) => _$MdomEditUserRequestTerminalsIsDelFromJson(json);

  Map<String, dynamic> toJson() => _$MdomEditUserRequestTerminalsIsDelToJson(this);
  
}

@JsonSerializable()
class MdomEditUserRequestTerminalsIsEdit {

  @JsonKey(name: 'TerminalKKS')
  final List<MdomEditUserRequestTerminalsIsEditTerminalKKS> terminalKKS;

  MdomEditUserRequestTerminalsIsEdit({
    required this.terminalKKS,
  });

  factory MdomEditUserRequestTerminalsIsEdit.fromJson(Map<String, dynamic> json) => _$MdomEditUserRequestTerminalsIsEditFromJson(json);

  Map<String, dynamic> toJson() => _$MdomEditUserRequestTerminalsIsEditToJson(this);
  
}

@JsonSerializable()
class MdomEditUserRequestTerminalsIsEditTerminalKKS {

  @JsonKey(name: '@Value')
  final String value;

  @JsonKey(name: 'Params')
  final List<MdomRequestParams> params;

  MdomEditUserRequestTerminalsIsEditTerminalKKS({
    required this.value,
    required this.params
  });

  factory MdomEditUserRequestTerminalsIsEditTerminalKKS.fromJson(Map<String, dynamic> json) => _$MdomEditUserRequestTerminalsIsEditTerminalKKSFromJson(json);

  Map<String, dynamic> toJson() => _$MdomEditUserRequestTerminalsIsEditTerminalKKSToJson(this);
  
}

@JsonSerializable()
class MdomEditUserRequestTerminalsIsAdd {

  @JsonKey(name: 'TerminalKKS')
  final List<MdomEditUserRequestTerminalsIsAddTerminalKKS> terminalKKS;

  MdomEditUserRequestTerminalsIsAdd({
    required this.terminalKKS,
  });

  factory MdomEditUserRequestTerminalsIsAdd.fromJson(Map<String, dynamic> json) => _$MdomEditUserRequestTerminalsIsAddFromJson(json);

  Map<String, dynamic> toJson() => _$MdomEditUserRequestTerminalsIsAddToJson(this);
  
}

@JsonSerializable()
class MdomEditUserRequestTerminalsIsAddTerminalKKS {

  @JsonKey(name: '@Value')
  final String value;

  @JsonKey(name: 'Params')
  final List<MdomRequestParams> params;

  MdomEditUserRequestTerminalsIsAddTerminalKKS({
    required this.value,
    required this.params
  });

  factory MdomEditUserRequestTerminalsIsAddTerminalKKS.fromJson(Map<String, dynamic> json) => _$MdomEditUserRequestTerminalsIsAddTerminalKKSFromJson(json);

  Map<String, dynamic> toJson() => _$MdomEditUserRequestTerminalsIsAddTerminalKKSToJson(this);
  
}