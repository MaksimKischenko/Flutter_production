// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'register_payment_claim_request.g.dart';

@JsonSerializable()
class PsTpORegisterPaymentClaimRequestWrapper {

  @JsonKey(name: 'PS_TP_O')
  final PsTpORegisterPaymentClaimRequest psTpO;

  PsTpORegisterPaymentClaimRequestWrapper(this.psTpO);

  factory PsTpORegisterPaymentClaimRequestWrapper.fromJson(Map<String, dynamic> json) => _$PsTpORegisterPaymentClaimRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpORegisterPaymentClaimRequestWrapperToJson(this);
  
}

@JsonSerializable()
class PsTpORegisterPaymentClaimRequest {

  @JsonKey(name: 'RegisterPaymentOfClaimRequest')
  final RegisterPaymentOfClaimRequest request;

  PsTpORegisterPaymentClaimRequest(this.request);

  factory PsTpORegisterPaymentClaimRequest.fromJson(Map<String, dynamic> json) => _$PsTpORegisterPaymentClaimRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpORegisterPaymentClaimRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class RegisterPaymentOfClaimRequest {
  @JsonKey(name: 'ClaimId')
  final int? claimId;

  @JsonKey(name:'PaySum')
  final double? paySum;

  @JsonKey(name: 'MemNumber')
  final String? memNumber;

  @JsonKey(name: 'MemDate')
  final String? memDate;

  @JsonKey(name: 'Account')
  final String? account;

  @JsonKey(name: 'Version')
  final int? version;

  @JsonKey(name: 'KeyRequest')
  final int? key;

  @JsonKey(name: 'Token')
  final String? token; 

  RegisterPaymentOfClaimRequest({
    this.claimId,
    this.paySum,
    this.memNumber,
    this.memDate,
    this.account,
    this.key,
    this.token,
    this.version
  });

  factory RegisterPaymentOfClaimRequest.fromJson(Map<String, dynamic> json) => _$RegisterPaymentOfClaimRequestFromJson(json);

  factory RegisterPaymentOfClaimRequest.empty() => RegisterPaymentOfClaimRequest();

  Map<String, dynamic> toJson() => _$RegisterPaymentOfClaimRequestToJson(this);


  RegisterPaymentOfClaimRequest copyWith({
    int? claimId,
    double? paySum,
    String? memNumber,
    String? memDate,
    String? account,
    int? version,
    int? key,
    String? token,
  }) => RegisterPaymentOfClaimRequest(
      claimId: claimId ?? this.claimId,
      paySum: paySum ?? this.paySum,
      memNumber: memNumber ?? this.memNumber,
      memDate: memDate ?? this.memDate,
      account: account ?? this.account,
      version: version ?? this.version,
      key: key ?? this.key,
      token: token ?? this.token,
    );
}

