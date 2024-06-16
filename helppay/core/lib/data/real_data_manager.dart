import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:helppay_core/config.dart';
import 'package:helppay_core/data/encriptor.dart';
import 'package:helppay_core/data/remote_models/qr_register_payment_request.dart';
import 'package:helppay_core/models/models.dart';
import 'package:helppay_core/utils/utils.dart';
import 'package:retrofit/retrofit.dart';

import 'data.dart';
import 'remote_models/common_models/common_models.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'real_data_manager');

class RealDataManager extends DataManager {
  RealDataManager(Dio dio) : super(dio);

  @override
  Future<ConfirmResponse> confirmRequest({
    required int diType,
    required PayRecordResponse service,
    bool isCanceled = false,
  }) {
    final confirmRequestPayRecord = ConfirmRequestPayRecord(
      paymentID: service.paymentID ?? 0,
      date: service.date ?? '',
      recordID: service.recordID ?? 0,
      confirmCode: isCanceled ? 0 : 1,
      cancelReason: '',
    );
    final confirmRequest = ConfirmRequest(
        terminalID: terminalId,
        diType: diType,
        version: versionKomplat,
        payRecord: confirmRequestPayRecord);
    final psEripConfirmRequest = PsEripConfirmRequest(confirmRequest);
    final wrapper = PsEripConfirmRequestWrapper(psEripConfirmRequest);
    return komplatApi.confirmRequest(wrapper).then((it) => it.psErip.response);
  }

  @override
  Future<GetPayListResponse> getPayListRequest({
    required int diType,
    FilterQr? filter,
    int? payCode,
    String? sessionId,
    List<AttrRecordRequest>? attrRecord,
  }) {
    final getPayListRequest = GetPayListRequest(
      terminalID: terminalId,
      diType: diType,
      filter: filter,
      version: versionKomplat,
      token: token,
      payCode: payCode,
      sessionId: sessionId,
      attrRecord: attrRecord,
    );
    final psEripGetPayListRequest = PsEripGetPayListRequest(getPayListRequest);
    final wrapper = PsEripGetPayListRequestWrapper(psEripGetPayListRequest);
    return komplatApi
        .getPayListRequest(wrapper)
        .then((it) => it.psErip.response);
  }

  @override
  Future<RunOperationResponse> runOperationRequest({
    required PayRecordResponse service,
    required String payDate,
    required Pan? pan,
    required TypePan? typePan,
    required int? diType,
    required List<AttrRecordRequest> attrs,
    required int? kioskReceipt,
  }) async {
    final runOperationRequest = RunOperationRequest(
      terminalID: terminalId,
      version: versionKomplat,
      payRecordCount: 1,
      diType: diType,
      token: token,
      pan: pan,
      typePan: typePan,
      kioskReceipt: kioskReceipt,
      payDate: payDate,
      payRecord: PayRecordRequest(
        attrRecord: attrs,
        code: service.code,
        recordID: '1',
        codeOut: service.codeOut,
        summa: service.summa,
        fine: service.fine,
        payCommission: service.payCommission,
        currency: service.currency,
      ),
    );

    final psEripRunOperationRequest =
        PsEripRunOperationRequest(runOperationRequest);
    final wrapper = PsEripRunOperationRequestWrapper(psEripRunOperationRequest);
    return komplatApi
        .runOperationRequest(wrapper)
        .then((it) => it.psErip.response);
  }

  RunOperationRequest getRunOperationRequest({
    required List<AttrRecordRequest> attrs,
    required PayRecordResponse service,
    required String lang,
  }) {
    final payRecordRequest = PayRecordRequest(
      code: service.code,
      attrRecord: attrs,
      codeOut: service.codeOut,
      nameOut: service.name,
      summa: service.summa,
      currency: service.currency,
      sessionId: service.sessionId,
    );
    return RunOperationRequest(
      kioskReceipt: null,
      diType: null,
      terminalID: terminalId,
      version: versionKomplat,
      token: token,
      payDate: DateTime.now().toStringFormatted(),
      payRecord: payRecordRequest,
      lang: Lang(evalue: lang),
    );
  }

  @override
  Future<GetBalanceResponse> getBalanceRequest({
    required Pan? pan,
    required int diType,
    required TypePan? typePan,
  }) async {
    final getBalanceRequest = GetBalanceRequest(
      terminalID: terminalId,
      version: versionKomplat,
      diType: diType, //TODO change to proper data
      token: token,
      pan: pan,
      typePan: typePan,
      currency: 933, //hardcoded be carefull
      requestType: 0, //0- for balance request, 1- for balance refill request
    );

    final psEripGetBalanceRequest = PsEripGetBalanceRequest(getBalanceRequest);
    final wrapper = PsEripGetBalanceRequestWrapper(psEripGetBalanceRequest);
    return komplatApi
        .getBalanceReguest(wrapper)
        .then((it) => it.psErip.response);
  }

  @override
  Future<MdomCreateResponse> createRequest({
    required String login,
    required String fio,
    required String password,
    String? phone,
    bool isSendCodeSMS = false,
  }) {
    final createRequest = MdomCreateRequest(
        login: MdomLogin(
          evalue: login,
          fio: fio,
          password: password,
        ),
        isSendCodeSMS: MdomCreateRequestIsSendCodeSMS(
            evalue: isSendCodeSMS ? 1 : null,
            phone: isSendCodeSMS ? phone : null),
        isSendCodeEMail: !isSendCodeSMS ? 1 : null);
    final wrapper = MdomCreateRequestWrapper(createRequest);
    return mdomApi.createRequest(wrapper).then((it) => it.userResponse);
  }

  @override
  Future<MdomLoginResponse> loginRequest({
    String? login,
    String? fio,
    String? password,
    int? code,
  }) async {
    late MdomLoginRequest loginRequest;
    if (login != null && password != null) {
      // auth with login
      loginRequest = MdomLoginRequest(
        login: MdomLogin(
          evalue: login,
          fio: fio ?? '',
          password: password,
        ),
      );
    } else {
      // auth with token, code and terminalId
      loginRequest = MdomLoginRequest(
        lang: await lang,
        tokenRecord: MdomTokenRecord(
          evalue: token,
          sendCode: code!,
          terminalId: terminalId,
        ),
      );
    }
    final wrapper = MdomLoginRequestWrapper(loginRequest);
    return mdomApi.loginRequest(wrapper).then((it) => it.userResponse);
  }

  @override
  Future<MdomDeleteUserResponse> deleteUserRequest({
    String? login,
    int? userId,
  }) async {
    final deleteUserRequest = MdomDeleteUserRequest(
      terminalId: terminalId,
      version: versionReg,
      token: token,
      lang: await lang,
      login: login,
      userId: userId,
    );
    final wrapper = MdomDeleteUserRequestWrapper(deleteUserRequest);
    return mdomApi.deleteUserRequest(wrapper).then((it) => it.userResponse);
  }

  @override
  Future<MdomEditUserResponse> editUserRequest({
    MdomRequestParams? userParams,
    MdomEditUserRequestProducts? products,
    MdomEditUserRequestTerminals? terminals,
    EditUserRequestNeedChangePassword? needChangePassword,
  }) async {
    final editUserRequest = MdomEditUserRequest(
        terminalId: terminalId,
        version: versionReg,
        token: token,
        lang: await lang,
        params: userParams,
        needChangePassword: needChangePassword,
        products: products,
        terminals: terminals);
    final wrapper = MdomEditUserRequestWrapper(editUserRequest);
    return mdomApi.editUserRequest(wrapper).then((it) => it.userResponse);
  }

  @override
  Future<MdomResetPasswordResponse> resetPasswordRequest({
    String? login,
    String? email,
    String? phone,
  }) async {
    final resetPasswordRequest = MdomResetPasswordRequest(
      login: MdomResetPasswordLogin(
        login: login,
        email: email,
        phone: phone,
      ),
    );
    final wrapper = MdomResetPasswordRequestWrapper(resetPasswordRequest);
    return mdomApi.resetPasswordRequest(wrapper).then((it) => it.userResponse);
  }

  @override
  Future<GetOperationHistoryResponse> getOperationHistoryRequest({
    required GetOperationHistoryRequestSourceId sourceId,
    required String dateFrom,
    required String dateTo,
    int count = 20,
    int? lastPaymentId,
  }) {
    final getOperationHistoryRequest = GetOperationHistoryRequest(
        terminalID: terminalId,
        version: versionKomplat,
        token: token,
        sourceId: sourceId,
        filter: GetOperationHistoryRequestFilter(
            dateFrom: dateFrom,
            dateTo: '$dateTo 23:59:59',
            listSize: count,
            lastPaymentId: lastPaymentId));
    final psEripGetOperationHistoryRequest =
        PsEripGetOperationHistoryRequest(getOperationHistoryRequest);
    final wrapper = PsEripGetOperationHistoryRequestWrapper(
        psEripGetOperationHistoryRequest);
    return komplatApi
        .getOperationHistoryRequest(wrapper)
        .then((it) => it.psErip.response);
  }

  @override
  Future<MdomCompaniesResponse> companiesRequest() async {
    final companiesRequest = MdomCompaniesRequest(
        terminalId: terminalId,
        version: mdomTpInfoVersion,
        token: token,
        lang: await lang);
    final wrapper = MdomCompaniesRequestWrapper(companiesRequest);
    return mdomTpInfoApi.companiesRequest(wrapper).then(
      (response) {
        token = response.response.token;
        return response.response;
      },
    );
  }

  @override
  Future<MdomRefreshTokenResponse> refreshTokenRequest(String token) async {
    final refreshRequest = MdomRefreshTokenRequest(
        terminalId: terminalId,
        version: mdomTpInfoVersion,
        token: token,
        lang: await lang);
    final wrapper = MdomRefreshTokenRequestWrapper(refreshRequest);
    return mdomApi
        .refreshTokenRequest(wrapper)
        .then((response) => response.response);
  }

  @override
  Future<MdomInfoSupplierResponse> infoSupplierRequest(
      {required int? supplierUNN, required String? supplierName}) async {
    final infoSupplierRequest = MdomInfoSupplierRequest(
      terminalId: terminalId,
      version: mdomTpInfoVersion,
      token: token,
      lang: await lang,
      filter: Filter(
        supplierUNN: supplierUNN,
        supplierName: supplierName,
      ),
    );
    final wrapper = MdomInfoSupplierRequestWrapper(infoSupplierRequest);
    return mdomTpInfoApi.infoSupplierRequest(wrapper).then(
      (response) {
        token = response.response.token;
        return response.response;
      },
    );
  }

  @override
  Future<MdomAccountRegistrationResponse> accountRegistrationRequest(
      {required String account,
      required int supplierId,
      required String? codeWord}) async {
    final accountRegistrationRequest = MdomAccountRegistrationRequest(
        terminalId: terminalId,
        version: mdomTpInfoVersion,
        token: token,
        lang: await lang,
        account: AccountRegistrationAccount(
            evalue: account, supplierId: supplierId, codeWord: codeWord));
    final wrapper =
        MdomAccountRegistrationRequestWrapper(accountRegistrationRequest);
    return mdomTpInfoApi.accountRegistrationRequest(wrapper).then(
      (response) {
        token = response.response.token;
        return response.response;
      },
    );
  }

  @override
  Future<MdomAccountStatementResponse> accountStatementRequest({
    required DateTime from,
    required DateTime to,
    required int supplierId,
    required String account,
  }) async {
    final accountStatementRequest = MdomAccountStatementRequest(
        terminalId: terminalId,
        version: mdomTpInfoVersion,
        token: token,
        lang: await lang,
        periodFrom: from.toStringFormatted(),
        periodTo: to.toStringFormattedGetOperationHistory(),
        supplierId: supplierId,
        account: account);
    final wrapper = MdomAccountStatementRequestWrapper(accountStatementRequest);
    return mdomTpInfoApi.accountStatementRequest(wrapper).then((response) {
      token = response.response.token;
      return response.response;
    });
  }

  @override
  Future<IndividualPollsListResponse> pollsListRequest({
    String? topic,
    required PollStatus status,
    required DateTime stopDateFrom,
    required DateTime stopDateTo,
    int? supplierId,
    int? count,
    int? lastPollId,
  }) async {
    final pollsListRequest = IndividualPollsListRequest(
        terminalId: MdomTpIntTerminalId(
          evalue: 'terminal',
          password: 'password',
        ),
        version: mdomTpIntVersion,
        keyRequest: key,
        lang: await lang,
        token: token,
        topic: topic,
        status: status,
        stopDateFrom: stopDateFrom.toStringFormattedGetOperationHistory(),
        stopDateTo: stopDateTo.toStringFormattedGetOperationHistory(),
        supplierId: supplierId,
        rowCount: IndividualPollsListRequestRowCount(
            evalue: count ?? CoreConfig.pollsListRequestLoadCount,
            pollId: lastPollId));
    final mdomTpIntIndividualPollsListRequest =
        MdomTpIntIndividualPollsListRequest(pollsListRequest);
    final wrapper = MdomTpIntIndividualPollsListRequestWrapper(
        mdomTpIntIndividualPollsListRequest);
    return mdomTpIntApi
        .pollsListRequest(wrapper)
        .then((it) => it.psTpInt.response);
  }

  @override
  Future<QuestionAnswersListResponse> questionAnswersListRequest({
    required int pollId,
    int? questionId,
  }) async {
    final questionAnswersListRequest = QuestionAnswersListRequest(
      terminalId: MdomTpIntTerminalId(evalue: 'terminal', password: 'password'),
      version: mdomTpIntVersion,
      keyRequest: key,
      lang: await lang,
      token: token,
      pollId: pollId,
      questionId: questionId,
    );
    final mdomTpIntQuestionAnswersListRequest =
        MdomTpIntQuestionAnswersListRequest(questionAnswersListRequest);
    final wrapper = MdomTpIntQuestionAnswersListRequestWrapper(
        mdomTpIntQuestionAnswersListRequest);
    return mdomTpIntApi
        .questionAnswersListRequest(wrapper)
        .then((it) => it.psTpInt.response);
  }

  @override
  Future<VotePollResponse> votePollRequest({
    required int pollId,
    required String account,
    required List<VotePollQuestion> questions,
  }) async {
    final votePollRequest = VotePollRequest(
      terminalId: MdomTpIntTerminalId(evalue: 'terminal', password: 'password'),
      version: mdomTpIntVersion,
      keyRequest: key,
      lang: await lang,
      token: token,
      pollId: pollId,
      account: account,
      questions: questions,
    );
    final mdomTpIntVotePollRequest = MdomTpIntVotePollRequest(votePollRequest);
    final wrapper = MdomTpIntVotePollRequestWrapper(mdomTpIntVotePollRequest);
    return mdomTpIntApi
        .votePollRequest(wrapper)
        .then((it) => it.psTpInt.response);
  }

  @override
  Future<NotificationListResponse> notifyListRequest({
    required int supplierId,
    required NotifyListRequestRowCount rowCount,
  }) async {
    final notifyListRequest = NotificationListRequest(
      terminalId: MdomTpIntTerminalId(evalue: 'terminal', password: 'password'),
      version: mdomTpIntVersion,
      keyRequest: key,
      lang: await lang,
      token: token,
      supplierId: supplierId,
      rowCount: rowCount,
    );

    final mdomTpIntNotificationListRequest =
        MdomTpIntNotifyListRequest(notifyListRequest);
    final wrapper =
        MdomTpIntNotifyListRequestWrapper(mdomTpIntNotificationListRequest);
    return mdomTpIntApi.notifyListRequest(wrapper).then(
          (it) => it.psTpInt.response,
        );
  }

  @override
  Future<NotificationReadResponse> notifyReadRequest(
      {required int lastNotificationIndicator}) async {
    final notifyReadRequest = NotificationReadRequest(
        terminalId: MdomTpIntTerminalId(
          evalue: 'terminal',
          password: 'password',
        ),
        version: mdomTpIntVersion,
        keyRequest: key,
        lang: await lang,
        token: token,
        lastNotificationIndicator: lastNotificationIndicator);

    final mdomTpIntNotificationReadRequest =
        MdomTpIntNotifyReadRequest(notifyReadRequest);
    final wrapper =
        MdomTpIntNotifyReadRequestWrapper(mdomTpIntNotificationReadRequest);
    return mdomTpIntApi.notifyReadRequest(wrapper).then(
          (it) => it.psTpInt.response,
        );
  }

  @override
  Future<GetPrimarySecretKeyResponse> getPrimarySecretKeyRequest(
      {required String terminalId}) async {
    final getPrimarySecretKeyRequest = komplatQrApi
        .getPrimarySecretKeyRequest(terminalId: terminalId)
        .then((value) => value);

    return getPrimarySecretKeyRequest.then((value) => value.response);
  }

  @override
  Future<HttpResponse<String>> getSecretKeyRequest({
    required String requestTime,
    required RegPayMinTerminalID terminalID,
    required String? typePan,
    required QrPan? pan,
  }) async {
    final getSecretKeyRequest = GetSecretKeyRequest(
        terminalId: terminalID, version: 1, pan: pan, typePan: typePan);

    final psEripGetSecretKeyRequest =
        PsHelppayGetSecretKeyRequest(getSecretKeyRequest);
    final _wrapperBody = json.encode(
        PsHelppayGetSecretKeyRequestWrapper(psEripGetSecretKeyRequest)
            .toJson());
    final _tempTerminalId = terminalID.evalue;
    final secretKey = await SecureStorageManager.read(
      SecureStorageKeys.secretKeyPart,
    );
    final _encryptedStringValue = Criptor().enctriptData(
      wrapperBody: _wrapperBody,
      requestTime: '',
      tempTerminalId: _tempTerminalId,
      secretKeyPart: secretKey ?? '',
    );
    _log(_encryptedStringValue);

    return komplatQrApi
        .getSecretKeyRequest(
          terminalId: _tempTerminalId,
          operationTime: requestTime,
          body: _encryptedStringValue,
        )
        .then((value) => value);
  }

  @override
  Future<HttpResponse<String>> getQrRequest({
    required String requestTime,
    required RegPayMinTerminalID terminalID,
    required String typePan,
    required QrPan pan,
    required double restSum,
    double? paymentSum,
  }) async {
    final _getQrRequest = GetQrRequest(
      terminalID: terminalID,
      version: 1,
      typePan: typePan,
      pan: pan,
      restSum: restSum,
      paymentSum: paymentSum,
    );

    final _psEripGetQrRequest = PsHelppayGetQrRequest(_getQrRequest);
    final _wrapperBody =
        json.encode(PsHelppayGetQrRequestWrapper(_psEripGetQrRequest).toJson());
    _log('qr request json bod - $_wrapperBody');
    final _tempTerminalId = terminalID.evalue;
    final secretKey = await SecureStorageManager.read(
      SecureStorageKeys.secretKeyPart,
    );

    final _encryptedStringValue = Criptor().enctriptData(
      requestTime: requestTime,
      tempTerminalId: _tempTerminalId,
      secretKeyPart: secretKey ?? '',
      wrapperBody: _wrapperBody,
    );

    _log(_encryptedStringValue);
    // _log('request time - $requestTime');

    return komplatQrApi
        .getQrRequest(
          terminalId: _tempTerminalId,
          operationTime: requestTime,
          body: _encryptedStringValue,
        )
        .then((value) => value);
  }

  @override
  Future<HttpResponse<String>> confirmQrPaymentRequest({
    required String requestTime,
    required RegPayMinTerminalID terminalID,
    required String typePan,
    required QrPan pan,
    required int requestId,
    required int? otpCode,
    required int confirmCode,
  }) async {
    final _confirmQrPaymentRequest = ConfirmQrPaymentRequest(
        terminalID: terminalID,
        version: 1,
        typePan: typePan,
        pan: pan,
        requestId: QrRequestId(
          evalue: requestId,
          confirmCode: confirmCode,
          otpCode: otpCode,
        ));

    final _psEripConfirmQrPaymentRequest =
        PsHelppayConfirmQrPaymentRequest(_confirmQrPaymentRequest);
    final _wrapperBody = json.encode(
        PsHelppayConfirmQrPaymentRequestWrapper(_psEripConfirmQrPaymentRequest)
            .toJson());
    final _tempTerminalId = terminalID.evalue;
    final secretKey = await SecureStorageManager.read(
      SecureStorageKeys.secretKeyPart,
    );
    final _encryptedStringValue = Criptor().enctriptData(
      requestTime: requestTime,
      tempTerminalId: _tempTerminalId,
      secretKeyPart: secretKey ?? '',
      wrapperBody: _wrapperBody,
    );

    return komplatQrApi
        .confirmQrPaymentRequest(
          terminalId: _tempTerminalId,
          operationTime: requestTime,
          body: _encryptedStringValue,
        )
        .then((value) => value);
  }

  @override
  Future<HttpResponse<String>> getQROperationRequest({
    required String requestTime,
    required RegPayMinTerminalID terminalID,
    required String typePan,
    required QrPan pan,
    required int requestId,
    required OperationFilter filter,
  }) async {
    final _getQROperationRequest = GetQROperationRequest(
      terminalID: terminalID,
      version: 1,
      typePan: typePan,
      pan: pan,
      filter: filter,
    );

    final _psHelpPayQROperationRequest =
        PsHelpPayQROperationRequest(_getQROperationRequest);
    final _wrapperBody = json.encode(
        PsHelpPayQROperationRequestWrapper(_psHelpPayQROperationRequest)
            .toJson());
    final _tempTerminalId = terminalID.evalue;
    final secretKey = await SecureStorageManager.read(
      SecureStorageKeys.secretKeyPart,
    );
    final _encryptedStringValue = Criptor().enctriptData(
      requestTime: requestTime,
      tempTerminalId: _tempTerminalId,
      secretKeyPart: secretKey ?? '',
      wrapperBody: _wrapperBody,
    );

    _log('operation request is $_wrapperBody');

    return komplatQrApi
        .getQROperationRequest(
          terminalId: _tempTerminalId,
          operationTime: requestTime,
          body: _encryptedStringValue,
        )
        .then((value) => value);
  }

  @override
  Future<HttpResponse<String>> getQRCheckDuplicateRequest({
    required String requestTime,
    required RegPayMinTerminalID terminalID,
    required String typePan,
    required QrPan pan,
    required int requestId,
    required int? advancedInfoRequired,
  }) async {
    final _getQROperationRequest = QRCheckDuplicateRequest(
      terminalID: terminalID,
      version: 1,
      typePan: typePan,
      pan: pan,
      requestId: requestId,
      advancedInfoRequired: advancedInfoRequired,
    );

    final _psHelpPayQROperationRequest =
        PsHelpPayQRCheckDuplicateRequest(_getQROperationRequest);
    final _wrapperBody = json.encode(
        PsHelpPayQRCheckDuplicateRequestWrapper(_psHelpPayQROperationRequest)
            .toJson());
    final _tempTerminalId = terminalID.evalue;
    final secretKey = await SecureStorageManager.read(
      SecureStorageKeys.secretKeyPart,
    );
    final _encryptedStringValue = Criptor().enctriptData(
      requestTime: requestTime,
      tempTerminalId: _tempTerminalId,
      secretKeyPart: secretKey ?? '',
      wrapperBody: _wrapperBody,
    );

    _log('operation request is $_wrapperBody');

    return komplatQrApi
        .getQRCheckDuplicateRequest(
          terminalId: _tempTerminalId,
          operationTime: requestTime,
          body: _encryptedStringValue,
        )
        .then((value) => value);
  }

  @override
  Future<HttpResponse<String>> getRequestStatusRequest({
    required String requestTime,
    required RegPayMinTerminalID terminalID,
    required int version,
    required String typePan,
    required QrPan pan,
    required int requestId,
  }) async {
    final _getQRRequestStatusRequest = QRRequestStatusRequest(
        terminalID: terminalID,
        version: 1,
        typePan: typePan,
        pan: pan,
        requestId: requestId
        // 130-135,
        );

    final _psHelpPayQRRequestStatusRequest =
        PsHelpPayQRRequestStatusRequest(_getQRRequestStatusRequest);
    final _wrapperBody = json.encode(
        PsHelpPayQRRequestStatusRequestWrapper(_psHelpPayQRRequestStatusRequest)
            .toJson());
    final _tempTerminalId = terminalID.evalue; //'MAX2131';
    final secretKey = await SecureStorageManager.read(
      SecureStorageKeys.secretKeyPart,
    );
    final _encryptedStringValue = Criptor().enctriptData(
      requestTime: requestTime,
      tempTerminalId: _tempTerminalId,
      secretKeyPart: secretKey ?? '', //TODO null check is wrong
      wrapperBody: _wrapperBody,
    );

    _log('operation request is $_wrapperBody');

    return komplatQrApi
        .getRequestStatusRequest(
          terminalId: _tempTerminalId,
          operationTime: requestTime,
          body: _encryptedStringValue,
        )
        .then((value) => value);
  }

  @override
  Future<HttpResponse<String>> registerPaymentRequest({
    required String requestTime,
    // required PayRecord payRecord,
    required RegPayMinTerminalID terminalID,
    required int version,
    required String typePan,
    required QrPan pan,
    required int requestId,
  }) async {
    final _getQRRequestStatusRequest = QrRegisterPaymentRequest(
      kioskReciept: requestId.toString(),
      paymentDate:
          '', //TODO //DateFormat('dd/MM/yyyy HH:mm:ss').format(requestTime),
      payRecord: PayRecord(
        attributes: [],

        //  <AttrRecord>[
        //   AttrRecord(
        //     code: 900,
        //     name: 'Идентификатор запроса',
        //     value: requestId.toString(), //TODO need to provide data
        //   ),
        //   AttrRecord(
        //     code: 878,
        //     name: 'Счет зачисления',
        //     value: pan.value, //TODO need to provide data
        //   ),
        // ],
        paymentSum: 0,
        currency: 933,
      ),
      terminalID: terminalID,
      version: 1,
      typePan: typePan,
      pan: pan,
      // requestId: requestId
      // 130-135,
    );

    final _psHelpPayQRRequestStatusRequest =
        PsHelppayQrRegisterPaymentRequest(_getQRRequestStatusRequest);
    final _wrapperBody = json.encode(PsHelppayQrRegisterPaymentRequestWrapper(
            _psHelpPayQRRequestStatusRequest)
        .toJson());
    final _tempTerminalId = terminalID.evalue; //'MAX2131';
    final secretKey = await SecureStorageManager.read(
      SecureStorageKeys.secretKeyPart,
    );
    final _encryptedStringValue = Criptor().enctriptData(
      requestTime: requestTime,
      tempTerminalId: _tempTerminalId,
      secretKeyPart: secretKey ?? '', //TODO null check is wrong
      wrapperBody: _wrapperBody,
    );

    _log('register payment request is $_wrapperBody');

    return komplatQrApi
        .registerPaymentRequest(
          terminalId: _tempTerminalId,
          operationTime: requestTime,
          body: _encryptedStringValue,
        )
        .then((value) => value);
  }

  @override
  Future<HttpResponse<String>> registerPaymentMethodRequest({
    required String requestTime,
    // required PayRecord payRecord,
    required RegPayMinTerminalID terminalID,
    required int version,
    required String typePan,
    QrPan? pan,
    CardEmissionParam? cardEmissionParam,
  }) async {
    final _getQRRequestStatusRequest = RegisterPaymentMethodRequest(
      terminalID: terminalID,
      version: 1,
      typePan: typePan,
      pan: pan,
      cardEmissionParam: cardEmissionParam,
      // requestId: requestId
      // 130-135,
    );

    final _psHelpPayQRRequestStatusRequest =
        PsHelppayRegisterPaymentMethodRequest(_getQRRequestStatusRequest);
    final _wrapperBody = json.encode(
        PsHelppayRegisterPaymentMethodRequestWrapper(
                _psHelpPayQRRequestStatusRequest)
            .toJson());
    final _tempTerminalId = terminalID.evalue; //'MAX2131';
    final secretKey = await SecureStorageManager.read(
      SecureStorageKeys.secretKeyPart,
    );
    final _encryptedStringValue = Criptor().enctriptData(
      requestTime: requestTime,
      tempTerminalId: _tempTerminalId,
      secretKeyPart: secretKey ?? '', //TODO null check is wrong
      wrapperBody: _wrapperBody,
    );

    _log('register payment request is $_wrapperBody');

    return komplatQrApi
        .registerPaymentMethodRequest(
          terminalId: _tempTerminalId,
          operationTime: requestTime,
          body: _encryptedStringValue,
        )
        .then((value) => value);
  }

  @override
  Future<HttpResponse<String>> confirmPaymentMethodRequest({
    required String requestTime,
    // required PayRecord payRecord,
    required RegPayMinTerminalID terminalID,
    required int version,
    required String typePan,
    required RequestIdentifier requestId,
    QrPan? pan,
  }) async {
    final _getQRRequestStatusRequest = ConfirmPaymentMethodRequest(
      terminalID: terminalID,
      version: 1,
      typePan: typePan,
      pan: pan,
      requestId: requestId, // need to transfer this
    );

    final _psHelpPayQRRequestStatusRequest =
        PsHelppayConfirmPaymentMethodRequest(_getQRRequestStatusRequest);
    final _wrapperBody = json.encode(
        PsHelppayConfirmPaymentMethodRequestWrapper(
                _psHelpPayQRRequestStatusRequest)
            .toJson());
    final _tempTerminalId = terminalID.evalue; //'MAX2131';
    final secretKey = await SecureStorageManager.read(
      SecureStorageKeys.secretKeyPart,
    );
    final _encryptedStringValue = Criptor().enctriptData(
      requestTime: requestTime,
      tempTerminalId: _tempTerminalId,
      secretKeyPart: secretKey ?? '', //TODO null check is wrong
      wrapperBody: _wrapperBody,
    );

    _log('register payment request is $_wrapperBody');

    return komplatQrApi
        .confirmPaymentMethodRequest(
          terminalId: _tempTerminalId,
          operationTime: requestTime,
          body: _encryptedStringValue,
        )
        .then((value) => value);
  }
}
