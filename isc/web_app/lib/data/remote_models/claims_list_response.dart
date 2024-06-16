import 'package:equatable/equatable.dart';
import 'package:isc_web_app/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'claims_list_response.g.dart';

@JsonSerializable()
class PsTpOClaimsListResponseWrapper {

  @JsonKey(name: 'PS_TP_O')
  final PsTpOClaimsListResponse psTpO;

  PsTpOClaimsListResponseWrapper(this.psTpO);

  factory PsTpOClaimsListResponseWrapper.fromJson(Map<String, dynamic> json) => _$PsTpOClaimsListResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOClaimsListResponseWrapperToJson(this);
}

@JsonSerializable()
class PsTpOClaimsListResponse {

  @JsonKey(name: 'ClaimsListResponse')
  final ClaimsListResponse response;

  PsTpOClaimsListResponse(this.response);

  factory PsTpOClaimsListResponse.fromJson(Map<String, dynamic> json) => _$PsTpOClaimsListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpOClaimsListResponseToJson(this);
}

@JsonSerializable()
class ClaimsListResponse {

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'KeyRequest')
  final int key;

  @JsonKey(name: 'Claim')
  final List<Claim>? claims;

  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  ClaimsListResponse({
    this.claims,
    required this.version,
    required this.key,
    required this.errorCode,
    this.errorText,
  });

  factory ClaimsListResponse.fromJson(Map<String, dynamic> json) => _$ClaimsListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimsListResponseToJson(this);
  
}

@JsonSerializable()
class Claim extends Equatable {

  @JsonKey(name: 'ClaimId')
  final int id;

  @JsonKey(name: 'AccNum')
  final String accNum;

  @JsonKey(name: 'InvoiceDate')
  final String invoiceDate;

  @JsonKey(name: 'DueDate')
  final String dueDate;

  @JsonKey(name: 'Status')
  final ClaimStatus status;

  @JsonKey(name: 'FIO')
  final String? fio;

  @JsonKey(name: 'ProductCharacter')
  final String? productCharacter;

  @JsonKey(name: 'Sum')
  final double sum;

  @JsonKey(name: 'PaymentSum')
  final double paymentSum;

  @JsonKey(name: 'QRCode')
  final String qrCode;

  const Claim({
    required this.id,
    required this.accNum,
    required this.invoiceDate,
    required this.dueDate,
    required this.status,
    required this.fio,
    this.productCharacter,
    required this.sum,
    required this.paymentSum,
    required this.qrCode
  });
  
  factory Claim.fromJson(Map<String, dynamic> json) => _$ClaimFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimToJson(this);


  @override
  List<Object?> get props => [
    id,
    accNum,
    invoiceDate,
    dueDate,
    status,
    fio,
    productCharacter,
    sum,
    paymentSum,
    qrCode
  ];
}
