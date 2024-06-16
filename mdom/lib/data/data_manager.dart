import 'dart:io';

import 'package:bpc/config.dart';
import 'package:bpc/models/models.dart';
import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';

import 'data.dart';

abstract class DataManager {
  final KomplatApi _komplatApi;
  final MdomApi _mdomApi;
  final MdomTpIntApi _mdomTpIntApi;
  final Dio dio;

  DataManager(this.dio)
      : _komplatApi = KomplatApi(dio, baseUrl: AppConfig.komplatApiUrl),
        _mdomApi = MdomApi(dio, baseUrl: AppConfig.mdomApiUrl),
        _mdomTpIntApi = MdomTpIntApi(dio, baseUrl: AppConfig.mdomTpIntApi);

  KomplatApi get komplatApi => _komplatApi;
  MdomApi get mdomApi => _mdomApi;
  MdomTpIntApi get mdomTpIntApi => _mdomTpIntApi;

  final int minPasswordLength = 6;
  final int version = 1;
  String token = '';
  String? email;
  List<MdomResponseParam>? userParams = [];
  String terminanlId = '';
  String versionReg = '1';
  final String mdomTpIntVersion = '1';
  ConfirmCodeType codeType = ConfirmCodeType.email;

  InformationResponse? informationResponse;

  //todo(set List, not mutable)
  List<Service> servicesList = [];

  int get key => DateTime.now().millisecondsSinceEpoch;

  bool get availableFeatures =>
      informationResponse?.confirmStatus == 1 &&
      servicesList.firstOrNull != null;

  bool isCredentialsSaveChecked = false;

  bool get isAvailableBiometricAuth => availableBiometrics.isNotEmpty;
  List<BiometricType> availableBiometrics = [];
  bool authWithBiometricsFlag = false;
  KomplatBiometricType? get komplatBiometricType {
    KomplatBiometricType? temp;
    if (kIsWeb) return null;
    if (Platform.isIOS) {
      if (availableBiometrics.contains(BiometricType.fingerprint)) {
        temp = KomplatBiometricType.touchid;
      } else if (availableBiometrics.contains(BiometricType.face)) {
        temp = KomplatBiometricType.faceid;
      }
    }
    return temp;
  }

  bool safeViewVisible = false;
  bool needCheckPin = false;

  Future<InformationResponse> informationRequest();

  Future<ClaimsListResponse> claimsListRequest({
    required Service service,
    required ClaimStatus status,
    required DateTime from,
    required DateTime to,
    int? claimId,
    String? accNum,
    int? count,
    int? lastClaimId,
  });

  Future<DeleteClaimResponse> deleteClaimRequest(int id);

  Future<AddClaimResponse> addClaimRequest(AddClaimRequest claim);

  Future<PaymentsListResponse> paymentListRequest({
    required Service service,
    required PaymentStatus status,
    required PaymentDateType dateType,
    required DateTime from,
    required DateTime to,
    String? accNum,
    int? claimId,
    int? count,
    int? lastPaymentId,
  });

  Future<ServicesListResponse> servicesListRequest();

  Future<AlgorithmListResponse> algorithmListRequest(int code);

  Future<void> loadServicesList();

  Future<MdomLoginResponse> loginRequest({
    String? login,
    String? fio,
    String? password,
    int? code,
  });

  Future<MdomCreateResponse> createRequest({
    required String login,
    required String fio,
    required String password,
    String? phone,
    bool isSendCodeSMS = false,
    String? keyRegistration,
  });

  Future<MdomEditUserResponse> editUserRequest(
      {MdomRequestParams? userParams,
      MdomEditUserRequestProducts? products,
      MdomEditUserRequestTerminals? terminals,
      EditUserRequestNeedChangePassword? needChangePassword});

  Future<EntityPollsListResponse> pollsListRequest({
    String? topic,
    PollStatus? status,
    required DateTime stopDateFrom,
    required DateTime stopDateTo,
    int? count,
    int? lastPollId,
  });

  Future<AddPollResponse> addPollRequest({
    required String topic,
    required DateTime startDate,
    required DateTime stopDate,
    String? url,
    required bool anonymous,
    bool publish = false,
    List<PollQuestionEdit>? questions,
  });

  Future<EditPollResponse> editPollRequest({
    required int id,
    String? topic,
    DateTime? startDate,
    DateTime? stopDate,
    String? url,
    bool? anonymous,
    bool? publish,
    List<PollQuestionEdit>? questions,
  });

  Future<DeletePollResponse> deletePollRequest({
    required int id,
  });

  Future<NotificationPollResponse> notificationPollRequest({
    required int id,
    required String message,
  });

  Future<CancelPollResponse> cancelPollRequest({
    required int id,
  });

  Future<PollMembersListResponse> pollMembersListRequest({
    required int id,
  });

  Future<QuestionAnswersListResponse> questionAnswersListRequest({
    required int pollId,
    int? questionId,
  });
}
