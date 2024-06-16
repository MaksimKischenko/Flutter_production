import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fl_qr_module/data/encriptor.dart';
import 'package:fl_qr_module/utils/date_helper.dart';
import 'package:fl_qr_module/utils/loger.dart';

import 'package:retrofit/retrofit.dart';

import 'data.dart';
import 'remote_models/common_models/common_models.dart';
import 'remote_models/qr_register_payment_request.dart';

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
        terminalID: nativeHostPayData?.terminalId ?? '',
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
      terminalID: nativeHostPayData?.terminalId ?? '',
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
      terminalID: nativeHostPayData?.terminalId ?? '',
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
      secretKeyPart: secretKey ?? '',
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
          '',
      payRecord: PayRecord(
        attributes: [],
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
      secretKeyPart: secretKey ?? '', 
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
      secretKeyPart: secretKey ?? '', 
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
      secretKeyPart: secretKey ?? '',
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
