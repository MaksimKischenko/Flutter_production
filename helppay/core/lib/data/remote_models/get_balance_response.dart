import 'package:json_annotation/json_annotation.dart';
part 'get_balance_response.g.dart';

@JsonSerializable()
class PsEripGetBalanceResponseWrapper {
  @JsonKey(name: 'PS_ERIP')
  final PsEripGetBalanceResponse psErip;

  PsEripGetBalanceResponseWrapper(this.psErip);

  factory PsEripGetBalanceResponseWrapper.fromJson(Map<String, dynamic> json) =>
      _$PsEripGetBalanceResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsEripGetBalanceResponseWrapperToJson(this);
}

@JsonSerializable(includeIfNull: false)
class PsEripGetBalanceResponse {
  @JsonKey(name: 'GetBalanceResponse')
  final GetBalanceResponse response;
  PsEripGetBalanceResponse(this.response);

  factory PsEripGetBalanceResponse.fromJson(Map<String, dynamic> json) =>
      _$PsEripGetBalanceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripGetBalanceResponseToJson(this);
}

@JsonSerializable(includeIfNull: false)
class GetBalanceResponse {
  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  @JsonKey(name: 'Balance')
  final Balance? balance;

  GetBalanceResponse({
    required this.errorCode,
    this.errorText,
    required this.balance,
  });

  factory GetBalanceResponse.fromJson(Map<String, dynamic> json) =>
      _$GetBalanceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetBalanceResponseToJson(this);
}

@JsonSerializable(includeIfNull: false)
class Balance {
  @JsonKey(name: '@SessionID')
  final int sessionID;

  @JsonKey(name: '@Amount')
  final double amount;

  @JsonKey(name: '@Currency')
  final int currency;

  @JsonKey(name: '@DraftEnabled')
  final String draftEnabled;

  @JsonKey(name: '@AddParams')
  final List<AditionalBalanceParam>? aditionalParams;

  Balance({
    required this.sessionID,
    required this.amount,
    required this.currency,
    required this.draftEnabled,
    this.aditionalParams,
  });

  factory Balance.fromJson(Map<String, dynamic> json) =>
      _$BalanceFromJson(json);

  Map<String, dynamic> toJson() => _$BalanceToJson(this);
}

@JsonSerializable(includeIfNull: false)
class AditionalBalanceParam {
  @JsonKey(name: '@Name')
  final String name;

  @JsonKey(name: '@Value')
  final String value;

  AditionalBalanceParam({
    required this.name,
    required this.value,
  });

  factory AditionalBalanceParam.fromJson(Map<String, dynamic> json) =>
      _$AditionalBalanceParamFromJson(json);

  Map<String, dynamic> toJson() => _$AditionalBalanceParamToJson(this);
}
