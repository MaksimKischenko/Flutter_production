import 'package:helppay_core/data/remote_models/mdom_base_models.dart';
import 'package:helppay_core/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class MdomLoginResponseWrapper {

  @JsonKey(name: 'UserResponse')
  final MdomLoginResponse userResponse;

  MdomLoginResponseWrapper(this.userResponse);

  factory MdomLoginResponseWrapper.fromJson(Map<String, dynamic> json) => _$MdomLoginResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomLoginResponseWrapperToJson(this);
  
}

@JsonSerializable()
class MdomLoginResponse {

  @JsonKey(name: 'RequestType')
  final String requestType;

  @JsonKey(name: 'ErrorCode')
  final MdomErrorCode errorCode;

  @JsonKey(name: 'Token')
  final MdomToken? token;

  @JsonKey(name: 'HelppayKey')
  final String? helppayKey;

  @JsonKey(name: 'Params')
  final MdomResponseParams? params;

  @JsonKey(name: 'Lookups')
  final MdomLookups? lookups;

  @JsonKey(name: 'Products')
  final MdomLoginResponseProducts? products;

  @JsonKey(name: 'Terminals')
  final MdomLoginResponseTerminals? terminals;

  const MdomLoginResponse({
    required this.requestType,
    required this.errorCode,
    required this.token,
    required this.helppayKey,
    this.params,
    this.lookups,
    this.products,
    this.terminals
  });

  factory MdomLoginResponse.fromJson(Map<String, dynamic> json) => _$MdomLoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MdomLoginResponseToJson(this);
  
}

@JsonSerializable()
class MdomLoginResponseProducts {

  @JsonKey(name: 'Current')
  final List<MdomLoginResponseProductsCurrent>? current;

  @JsonKey(name: 'RuleNew')
  final List<MdomLoginResponseProductsCurrent> ruleNew;

  MdomLoginResponseProducts({
    this.current,
    required this.ruleNew
  });

  factory MdomLoginResponseProducts.fromJson(Map<String, dynamic> json) => _$MdomLoginResponseProductsFromJson(json);

  Map<String, dynamic> toJson() => _$MdomLoginResponseProductsToJson(this);

  MdomLoginResponseProductsCurrent findRuleByAlias(String alias) => ruleNew.firstWhere((rule) {
    final typePan = rule.params.findByAlias(AliasList.typePan);
    if (typePan == null) return false;
    return typePan.evalue == alias;
  });

  List<MdomLoginResponseProductsCurrent> getCards() => current?.where((product) {
    final typePan = product.params.findByAlias(AliasList.typePan);
    if (typePan == null) return false;
    return typePan.evalue == AliasList.typePanCard;
  }).toList() ?? [];

  List<MdomLoginResponseProductsCurrent> getAccounts() => current?.where((product) {
    final typePan = product.params.findByAlias(AliasList.typePan);
    if (typePan == null) return false;
    return typePan.evalue == AliasList.typePanAccount;
  }).toList() ?? [];
  
}

@JsonSerializable()
class MdomLoginResponseProductsCurrent {

  @JsonKey(name: 'Params')
  final MdomResponseParams params;

  @JsonKey(name: 'Lookups')
  final MdomLookups? lookups;

  MdomLoginResponseProductsCurrent({
    required this.params,
    this.lookups
  });

  factory MdomLoginResponseProductsCurrent.fromJson(Map<String, dynamic> json) => _$MdomLoginResponseProductsCurrentFromJson(json);

  Map<String, dynamic> toJson() => _$MdomLoginResponseProductsCurrentToJson(this);
  
}

@JsonSerializable()
class MdomLoginResponseTerminals {

  @JsonKey(name: 'TerminalKKS')
  final List<MdomLoginResponseTerminalsTerminalKKS> terminals;

  MdomLoginResponseTerminals({
    required this.terminals,
  });

  factory MdomLoginResponseTerminals.fromJson(Map<String, dynamic> json) => _$MdomLoginResponseTerminalsFromJson(json);

  Map<String, dynamic> toJson() => _$MdomLoginResponseTerminalsToJson(this);
  
}

@JsonSerializable()
class MdomLoginResponseTerminalsTerminalKKS {

  @JsonKey(name: '@Value')
  final String evalue;

  @JsonKey(name: 'Params')
  final MdomResponseParams params;

  @JsonKey(name: 'Lookups')
  final MdomLookups? lookups;

  MdomLoginResponseTerminalsTerminalKKS({
    required this.evalue,
    required this.params,
    this.lookups
  });

  factory MdomLoginResponseTerminalsTerminalKKS.fromJson(Map<String, dynamic> json) => _$MdomLoginResponseTerminalsTerminalKKSFromJson(json);

  Map<String, dynamic> toJson() => _$MdomLoginResponseTerminalsTerminalKKSToJson(this);
  
}