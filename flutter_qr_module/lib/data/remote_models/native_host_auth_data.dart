import 'package:json_annotation/json_annotation.dart';

part 'native_host_auth_data.g.dart';

@JsonSerializable(includeIfNull: false)
class NativeHostAuthData {

  @JsonKey(name: 'qrScanUrl')
  final String qrScanUrl;

  @JsonKey(name: 'qrPayUrl')
  final String qrPayUrl;

  @JsonKey(name: 'terminalId')
  final String terminalId;

  @JsonKey(name: 'typePan')
  final String typePan;

  @JsonKey(name: 'pan')
  final String pan;

  @JsonKey(name: 'expiry')
  final String? expiry;


  NativeHostAuthData({
    required this.qrScanUrl,
    required this.qrPayUrl,
    required this.terminalId,
    required this.typePan,
    required this.pan,
    this.expiry,
  });

  factory NativeHostAuthData.fromJson(Map<String, dynamic> json) => _$NativeHostAuthDataFromJson(json);
  
}