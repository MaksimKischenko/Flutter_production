// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:helppay_core/data/remote_models/common_models/common_models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_secret_key_request.g.dart';

@JsonSerializable()
class PsHelppayGetSecretKeyRequestWrapper {
  @JsonKey(name: 'PS_HELPPAY')
  final PsHelppayGetSecretKeyRequest psErip;

  PsHelppayGetSecretKeyRequestWrapper(this.psErip);

  factory PsHelppayGetSecretKeyRequestWrapper.fromJson(
          Map<String, dynamic> json) =>
      _$PsHelppayGetSecretKeyRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsHelppayGetSecretKeyRequestWrapperToJson(this);
}

@JsonSerializable()
class PsHelppayGetSecretKeyRequest {
  @JsonKey(name: 'GetSecretKeyRequest')
  final GetSecretKeyRequest request;

  PsHelppayGetSecretKeyRequest(this.request);

  factory PsHelppayGetSecretKeyRequest.fromJson(Map<String, dynamic> json) =>
      _$PsHelppayGetSecretKeyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PsHelppayGetSecretKeyRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class GetSecretKeyRequest {
  @JsonKey(name: 'TerminalID')
  final RegPayMinTerminalID terminalId;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'TypePAN')
  final String? typePan;

  @JsonKey(name: 'PAN')
  final QrPan? pan;

  GetSecretKeyRequest({
    required this.terminalId,
    required this.version,
    required this.typePan,
    required this.pan,
  });

  factory GetSecretKeyRequest.fromJson(Map<String, dynamic> json) =>
      _$GetSecretKeyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetSecretKeyRequestToJson(this);
}
