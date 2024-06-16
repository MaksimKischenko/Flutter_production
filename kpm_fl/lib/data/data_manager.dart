import 'package:dio/dio.dart';

import 'data.dart';

abstract class DataManager {
  final KomplatApi _komplatApi;
  final MtApi _mtApi;
  final IpifyApi _ipifyApi;
  final Dio dio;
  String? kioskReceipt;
  String? barcode;
  /// used for counting RecordID attr in RunOperation
  int paymentsCount = 0;

  DataManager(this.dio) : _komplatApi = KomplatApi(dio),
    _mtApi = MtApi(dio),
    _ipifyApi = IpifyApi(dio);

  KomplatApi get komplatApi => _komplatApi;
  MtApi get mtApi => _mtApi;
  IpifyApi get ipifyApi => _ipifyApi;

  Future<ListPopularResponse> listPopularRequest({
    required int count
  });

  Future<GetPayListResponse> getPayListRequest({
    required int payCode,
    String? sessionId,
    List<AttrRecordRequest>? attrRecord,
    double? sum,
    int? currency,
    List<RequestProperty>? properties
  });

  Future<GetUserProfileResponse> getUserProfileRequest();

  Future<RunOperationResponse> runOperationRequest({
    required PayRecordResponse service,
    required List<AttrRecordRequest> attrs,
    required String kioskReceipt,
    List<RequestProperty>? properties
  });

  Future<OpenBasketResponse> openBasketRequest();

  Future<CloseBasketResponse> closeBasketRequest({
    required String barcode
  });

  Future<ConfirmResponse> confirmRequest({
    required PayRecordResponse service,
    bool isCanceled = false
  });

  Future<SearchBasketResponse> searchBasket({
    required String barcode
  });

  Future<String> getIpAddress();

  Future<CheckConnectResponse> checkConnectRequest({
    required String ipAddress
  });

}