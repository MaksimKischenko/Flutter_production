// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:helppay_core/data/remote_models/common_models/common_models.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:local_auth/local_auth.dart';
import 'package:retrofit/retrofit.dart';

abstract class DataManager {
  final KomplatApi _komplatApi;
  final KomplatQrApi _komplatQrApi;
  final MdomApi _mdomApi;
  final MdomTpInfoApi _mdomTpInfoApi;
  final MdomTpIntApi _mdomTpIntApi;
  final Dio dio;

  DataManager(this.dio)
      : _komplatApi = KomplatApi(dio, baseUrl: CoreConfig.komplatApiUrl),
        _komplatQrApi = KomplatQrApi(dio, baseUrl: CoreConfig.komplatQrApiUrl),
        _mdomApi = MdomApi(dio, baseUrl: CoreConfig.mdomApiUrl),
        _mdomTpInfoApi = MdomTpInfoApi(dio, baseUrl: CoreConfig.mdomTpInfoApi),
        _mdomTpIntApi = MdomTpIntApi(dio, baseUrl: CoreConfig.mdomTpIntApi);

  int get key => DateTime.now().millisecondsSinceEpoch;

  KomplatApi get komplatApi => _komplatApi;
  KomplatQrApi get komplatQrApi => _komplatQrApi;
  MdomApi get mdomApi => _mdomApi;
  MdomTpInfoApi get mdomTpInfoApi => _mdomTpInfoApi;
  MdomTpIntApi get mdomTpIntApi => _mdomTpIntApi;

  Future<String> get lang async =>
      (await PreferencesHelper.read(PrefsKeys.language))!;

  MdomLoginResponseProducts? userProducts;
  MdomResponseParams get accountParams =>
      userProducts!.findRuleByAlias(AliasList.typePanAccount).params;
  MdomResponseParams get cardParams =>
      userProducts!.findRuleByAlias(AliasList.typePanCard).params;
  List<MdomLoginResponseProductsCurrent> get accountsList =>
      userProducts?.getAccounts() ?? [];
  List<MdomLoginResponseProductsCurrent> get cardsList =>
      userProducts?.getCards() ?? [];

  String? get cardBankId => cardParams.findByAlias(AliasList.bankId)?.evalue;
  String? get cardContractKind =>
      cardParams.findByAlias(AliasList.contractKind)?.evalue;
  //TODO kReleaseMode
  String? get cardPictureUrl =>
      'http://192.168.244.126:8085/helppay_payform/imgs/${cardParams.findByAlias(AliasList.pictureUrl)?.evalue}';

  MdomLoginResponseProductsCurrent? get mainProduct =>
      userProducts?.current?.firstOrNullWhere((product) {
        final defaultFlag = product.params.findByAlias(AliasList.defaultFlag);
        if (defaultFlag == null) return false;

        return defaultFlag.evalue == '1';
      });

  MainProductType? get mainProductType {
    final typePan = mainProduct?.params.findByAlias(AliasList.typePan);
    if (typePan?.evalue == AliasList.typePanAccount) {
      return MainProductType.account;
    }
    if (typePan?.evalue == AliasList.typePanCard) {
      return MainProductType.card;
    }
    return null;
  }

  List<MdomResponseParam>? userParams = [];
  MdomLookup? lookups;
  String? email;
  String? login;
  String get username {
    final name =
        userParams?.firstOrNullWhere((param) => param.id == 13)?.evalue;
    final surname =
        userParams?.firstOrNullWhere((param) => param.id == 12)?.evalue;
    return "${name ?? ''} ${surname ?? ''}";
  }

  String token = '';
  String terminalId = '';
  int versionKomplat = 3;
  String versionReg = '1';
  final String mdomTpInfoVersion = '1';
  final String mdomTpIntVersion = '1';

  ConfirmCodeType codeType = ConfirmCodeType.email;

  /// pin & biometric auth features

  bool get isAvailableBiometricAuth => availableBiometrics.isNotEmpty;
  List<BiometricType> availableBiometrics = <BiometricType>[];
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

  /// END of pin & biometric auth features

  Future<ConfirmResponse> confirmRequest(
      {required PayRecordResponse service,
      required int diType,
      bool isCanceled = false});

  Future<GetPayListResponse> getPayListRequest({
    required int diType,
    FilterQr? filter,
    int? payCode,
    String? sessionId,
    List<AttrRecordRequest>? attrRecord,
  });

  Future<RunOperationResponse> runOperationRequest({
    required PayRecordResponse service,
    required List<AttrRecordRequest> attrs,
    required Pan? pan,
    required TypePan? typePan,
    required String payDate,
    required int? diType,
    required int? kioskReceipt,
  });

  Future<GetBalanceResponse> getBalanceRequest({
    required Pan? pan,
    required TypePan? typePan,
    required int diType,
  });

  Future<MdomCreateResponse> createRequest({
    required String login,
    required String fio,
    required String password,
    String? phone,
    bool isSendCodeSMS = false,
  });

  Future<MdomLoginResponse> loginRequest(
      {String? login, String? password, int? code});

  Future<MdomResetPasswordResponse> resetPasswordRequest(
      {String? login, String? email, String? phone});

  Future<MdomEditUserResponse> editUserRequest(
      {MdomRequestParams? userParams,
      MdomEditUserRequestProducts? products,
      MdomEditUserRequestTerminals? terminals,
      EditUserRequestNeedChangePassword? needChangePassword});

  Future<MdomDeleteUserResponse> deleteUserRequest({
    String? login,
    int? userId,
  });

  Future<GetOperationHistoryResponse> getOperationHistoryRequest({
    required GetOperationHistoryRequestSourceId sourceId,
    required String dateFrom,
    required String dateTo,
    int count = 20,
    int? lastPaymentId,
  });

  Future<MdomCompaniesResponse> companiesRequest();

  Future<MdomInfoSupplierResponse> infoSupplierRequest(
      {required int? supplierUNN, required String? supplierName});

  Future<MdomAccountRegistrationResponse> accountRegistrationRequest({
    required String account,
    required int supplierId,
    required String? codeWord,
  });

  Future<MdomAccountStatementResponse> accountStatementRequest({
    required DateTime from,
    required DateTime to,
    required int supplierId,
    required String account,
  });

  Future<MdomRefreshTokenResponse> refreshTokenRequest(
    String token,
  );

  Future<IndividualPollsListResponse> pollsListRequest({
    String? topic,
    required PollStatus status,
    required DateTime stopDateFrom,
    required DateTime stopDateTo,
    int? supplierId,
    int? count,
    int? lastPollId,
  });

  Future<QuestionAnswersListResponse> questionAnswersListRequest({
    required int pollId,
    int? questionId,
  });

  Future<VotePollResponse> votePollRequest({
    required int pollId,
    required String account,
    required List<VotePollQuestion> questions,
  });

  Future<NotificationListResponse> notifyListRequest({
    required int supplierId,
    required NotifyListRequestRowCount rowCount,
  });

  Future<NotificationReadResponse> notifyReadRequest({
    required int lastNotificationIndicator,
  });

  Future<GetPrimarySecretKeyResponse> getPrimarySecretKeyRequest({
    required String terminalId,
  });

  Future<HttpResponse<String>> getSecretKeyRequest({
    required String requestTime,
    required RegPayMinTerminalID terminalID,
    required String? typePan,
    required QrPan? pan,
  });

  Future<HttpResponse<String>> getQrRequest({
    required String requestTime,
    required RegPayMinTerminalID terminalID,
    required String typePan,
    required QrPan pan,
    required double restSum,
    double? paymentSum,
  });

  Future<HttpResponse<String>> confirmQrPaymentRequest({
    required String requestTime,
    required RegPayMinTerminalID terminalID,
    required String typePan,
    required QrPan pan,
    required int requestId,
    required int? otpCode,
    required int confirmCode,
  });

  Future<HttpResponse<String>> getQROperationRequest({
    required String requestTime,
    required RegPayMinTerminalID terminalID,
    required String typePan,
    required QrPan pan,
    required int requestId,
    required OperationFilter filter,
  });

  Future<HttpResponse<String>> getQRCheckDuplicateRequest({
    required String requestTime,
    required RegPayMinTerminalID terminalID,
    required String typePan,
    required QrPan pan,
    required int requestId,
    required int? advancedInfoRequired,
  });

  Future<HttpResponse<String>> getRequestStatusRequest({
    required String requestTime,
    required RegPayMinTerminalID terminalID,
    required int version,
    required String typePan,
    required QrPan pan,
    required int requestId,
  });

  Future<HttpResponse<String>> registerPaymentRequest({
    required String requestTime,
    // required PayRecord payRecord,
    required RegPayMinTerminalID terminalID,
    required int version,
    required String typePan,
    required QrPan pan,
    required int requestId,
  });

  Future<HttpResponse<String>> registerPaymentMethodRequest(
      {required String requestTime,
      // required PayRecord payRecord,
      required RegPayMinTerminalID terminalID,
      required int version,
      required String typePan,
      QrPan? pan,
      CardEmissionParam? cardEmissionParam});

  Future<HttpResponse<String>> confirmPaymentMethodRequest({
    required String requestTime,
    // required PayRecord payRecord,
    required RegPayMinTerminalID terminalID,
    required int version,
    required String typePan,
    required RequestIdentifier requestId,
    QrPan? pan,
  });

  @override
  bool operator ==(covariant DataManager other) {
    if (identical(this, other)) return true;

    return other._komplatApi == _komplatApi &&
        other._komplatQrApi == _komplatQrApi &&
        other._mdomApi == _mdomApi &&
        other._mdomTpInfoApi == _mdomTpInfoApi &&
        other._mdomTpIntApi == _mdomTpIntApi &&
        other.dio == dio;
  }

  @override
  int get hashCode {
    return _komplatApi.hashCode ^
        _komplatQrApi.hashCode ^
        _mdomApi.hashCode ^
        _mdomTpInfoApi.hashCode ^
        _mdomTpIntApi.hashCode ^
        dio.hashCode;
  }
}
