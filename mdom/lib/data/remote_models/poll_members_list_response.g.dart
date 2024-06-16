// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_members_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomTpIntPollMembersListResponseWrapper
    _$MdomTpIntPollMembersListResponseWrapperFromJson(
            Map<String, dynamic> json) =>
        MdomTpIntPollMembersListResponseWrapper(
          MdomTpIntPollMembersListResponse.fromJson(
              json['PS_TP_O_INT'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MdomTpIntPollMembersListResponseWrapperToJson(
        MdomTpIntPollMembersListResponseWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O_INT': instance.psTpInt,
    };

MdomTpIntPollMembersListResponse _$MdomTpIntPollMembersListResponseFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntPollMembersListResponse(
      PollMembersListResponse.fromJson(
          json['PollMembersListResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntPollMembersListResponseToJson(
        MdomTpIntPollMembersListResponse instance) =>
    <String, dynamic>{
      'PollMembersListResponse': instance.response,
    };

PollMembersListResponse _$PollMembersListResponseFromJson(
        Map<String, dynamic> json) =>
    PollMembersListResponse(
      version: json['Version'] as int,
      keyRequest: json['KeyRequest'] as int,
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
      members: (json['Member'] as List<dynamic>?)
          ?.map((e) => Member.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PollMembersListResponseToJson(
        PollMembersListResponse instance) =>
    <String, dynamic>{
      'Version': instance.version,
      'KeyRequest': instance.keyRequest,
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
      'Member': instance.members,
    };

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      id: json['@Id'] as int,
      clientAccount: json['@ClientAccount'] as String,
      fio: json['@FIO'] as String?,
      address: json['@Address'] as String?,
      phone: json['@Phone'] as int?,
      email: json['@EMail'] as String?,
      confirmed: json['@Confirmed'] as int?,
      voted: json['@Voted'] as int?,
    );

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      '@Id': instance.id,
      '@ClientAccount': instance.clientAccount,
      '@FIO': instance.fio,
      '@Address': instance.address,
      '@Phone': instance.phone,
      '@EMail': instance.email,
      '@Confirmed': instance.confirmed,
      '@Voted': instance.voted,
    };
