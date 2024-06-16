import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'poll_members_list_response.g.dart';

@JsonSerializable()
class MdomTpIntPollMembersListResponseWrapper {

  @JsonKey(name: 'PS_TP_O_INT')
  final MdomTpIntPollMembersListResponse psTpInt;

  MdomTpIntPollMembersListResponseWrapper(this.psTpInt);

  factory MdomTpIntPollMembersListResponseWrapper.fromJson(Map<String, dynamic> json) => _$MdomTpIntPollMembersListResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntPollMembersListResponseWrapperToJson(this);
  
}

@JsonSerializable()
class MdomTpIntPollMembersListResponse {

  @JsonKey(name: 'PollMembersListResponse')
  final PollMembersListResponse response;

  MdomTpIntPollMembersListResponse(this.response);

  factory MdomTpIntPollMembersListResponse.fromJson(Map<String, dynamic> json) => _$MdomTpIntPollMembersListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntPollMembersListResponseToJson(this);
  
}

@JsonSerializable()
class PollMembersListResponse {

  // general part

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'KeyRequest')
  final int keyRequest;

  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  // general part END

  @JsonKey(name: 'Member')
  final List<Member>? members;

  const PollMembersListResponse({
    required this.version,
    required this.keyRequest,
    required this.errorCode,
    this.errorText,
    this.members,
  });

  factory PollMembersListResponse.fromJson(Map<String, dynamic> json) => _$PollMembersListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PollMembersListResponseToJson(this);

}

@JsonSerializable()
class Member extends Equatable {

  @JsonKey(name: '@Id')
  final int id;

  @JsonKey(name: '@ClientAccount')
  final String clientAccount;

  @JsonKey(name: '@FIO')
  final String? fio;

  @JsonKey(name: '@Address')
  final String? address;

  @JsonKey(name: '@Phone')
  final int? phone;

  @JsonKey(name: '@EMail')
  final String? email;

  @JsonKey(name: '@Confirmed')
  final int? confirmed;

  @JsonKey(name: '@Voted')
  final int? voted;

  const Member({
    required this.id,
    required this.clientAccount,
    this.fio,
    this.address,
    this.phone,
    this.email,
    required this.confirmed,
    required this.voted,
  });

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);

  Member copyWith({
    int? id,
    String? clientAccount,
    String? fio,
    String? address,
    int? phone,
    String? email,
    int? confirmed,
    int? voted,
  }) => Member(
    id: id ?? this.id,
    clientAccount: clientAccount ?? this.clientAccount,
    fio: fio ?? this.fio,
    address: address ?? this.address,
    phone: phone ?? this.phone,
    email: email ?? this.email,
    confirmed: confirmed ?? this.confirmed,
    voted: voted ?? this.voted,
  );

  @override
  List<Object?> get props => [
    id,
    clientAccount,
    fio,
    address,
    phone,
    email,
    confirmed,
    voted,
  ];
}
