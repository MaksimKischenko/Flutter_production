import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'data.dart';
import 'remote_models/common_models/common_models.dart';

class FakeDataManager extends DataManager {
  FakeDataManager(Dio dio) : super(dio);

  final _delay = Future<void>.delayed(const Duration(seconds: 2));

  @override
  Future<ConfirmResponse> confirmRequest({
    required int diType,
    required PayRecordResponse service,
    bool isCanceled = false,
  }) async {
    await _delay;
    return const ConfirmResponse(
      errorCode: 1,
      errorText: 'unimplemented',
    );
  }

  @override
  Future<GetPayListResponse> getPayListRequest({
    required int diType,
    FilterQr? filter,
    int? payCode,
    String? sessionId,
    List<AttrRecordRequest>? attrRecord,
  }) async {
    await _delay;
    return const GetPayListResponse(
      errorCode: 1,
      errorText: 'unimplemented',
    );
  }

  @override
  Future<RunOperationResponse> runOperationRequest({
    required PayRecordResponse service,
    required Pan? pan,
    required TypePan? typePan,
    required List<AttrRecordRequest> attrs,
    required int? kioskReceipt,
    required int? diType,
    required String payDate,
  }) async {
    await _delay;
    return const RunOperationResponse(
      errorCode: 1,
      errorText: 'unimplemented',
    );
  }


  @override
  Future<GetPrimarySecretKeyResponse> getPrimarySecretKeyRequest(
      {required String terminalId}) async {
    await _delay;
    return GetPrimarySecretKeyResponse(secretKey: '11111111', errorCode: 0);
  }

  @override
  Future<HttpResponse<String>> getSecretKeyRequest({
    required String requestTime,
    required RegPayMinTerminalID terminalID,
    required String? typePan,
    required QrPan? pan,
  }) async {
    await _delay;
    return HttpResponse(
        '', Response<dynamic>(requestOptions: RequestOptions(path: '')));
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
    await _delay;

    return HttpResponse(
        '', Response<dynamic>(requestOptions: RequestOptions(path: '')));
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
    await _delay;
    return HttpResponse(
        '', Response<dynamic>(requestOptions: RequestOptions(path: '')));
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
    await _delay;

    return HttpResponse(
        '', Response<dynamic>(requestOptions: RequestOptions(path: '')));
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
    await _delay;

    return HttpResponse(
        '', Response<dynamic>(requestOptions: RequestOptions(path: '')));
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
    await _delay;

    return HttpResponse(
        '', Response<dynamic>(requestOptions: RequestOptions(path: '')));
  }

  @override
  Future<HttpResponse<String>> registerPaymentRequest({
    required String requestTime,
    required RegPayMinTerminalID terminalID,
    required int version,
    required String typePan,
    required QrPan pan,
    required int requestId,
  }) async {
    await _delay;

    return HttpResponse(
        '', Response<dynamic>(requestOptions: RequestOptions(path: '')));
  }

  @override
  Future<HttpResponse<String>> registerPaymentMethodRequest(
      {required String requestTime,
      required RegPayMinTerminalID terminalID,
      required int version,
      required String typePan,
      QrPan? pan,
      CardEmissionParam? cardEmissionParam}) async {
    await _delay;

    return HttpResponse(
        '', Response<dynamic>(requestOptions: RequestOptions(path: '')));
  }

  @override
  Future<HttpResponse<String>> confirmPaymentMethodRequest({
    required String requestTime,
    required RegPayMinTerminalID terminalID,
    required int version,
    required String typePan,
    required RequestIdentifier requestId,
    QrPan? pan,
  }) async {
    await _delay;

    return HttpResponse(
        '', Response<dynamic>(requestOptions: RequestOptions(path: '')));
  }

}
