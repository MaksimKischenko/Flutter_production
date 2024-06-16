import 'package:dio/dio.dart';
import 'package:fl_qr_module/data/data.dart';
import 'package:fl_qr_module/models/models.dart';
import 'package:retrofit/retrofit.dart';

import 'remote_models/common_models/common_models.dart';



abstract class DataManager {


  final Dio dio;

  DataManager(this.dio);


  int get key => DateTime.now().millisecondsSinceEpoch;

  KomplatApi get komplatApi => KomplatApi(dio, baseUrl: nativeHostPayData?.qrScanUrl ?? '');

  KomplatQrApi get komplatQrApi =>  KomplatQrApi(dio, baseUrl: nativeHostPayData?.qrPayUrl ?? '');

  NativeHostAuthData? nativeHostPayData;


  //TODO DONE
  MainProductType? get mainProductType {
    final typePan = nativeHostPayData?.typePan;     
    if (typePan?.toUpperCase() == AliasList.typePanAccount) {
      return MainProductType.account;
    }
    if (typePan?.toUpperCase() == AliasList.typePanCard) {
      return MainProductType.card;
    }
    return null;
  }


  String token = '';
  String terminalId = '';
  int versionKomplat = 3;
  String versionReg = '1';
  final String mdomTpInfoVersion = '1';
  final String mdomTpIntVersion = '1';
  bool safeViewVisible = false;



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
}
