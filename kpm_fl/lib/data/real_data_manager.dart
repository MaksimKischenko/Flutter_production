import 'package:dio/dio.dart';
import 'package:kpm_fl/config.dart';
import 'package:kpm_fl/utils/utils.dart';

import 'data.dart';

class RealDataManager extends DataManager {
  RealDataManager(Dio dio) : super(dio);

  // int get key => DateTime.now().millisecondsSinceEpoch;

  final int _komplatVersion = 3;
  final int _shopVersion = 4;
  final String _psEripLang = 'ru';
  // final String _psEripTerminalId = AppConfig.terminalId;
  // String? token;
  // String? login;


  Future<PAN> get pan async  {
    final pan = await PreferencesHelper.read(PrefsKeys.pan);
    if (pan == null) throw Exception('pan is null');

    return PAN(evalue: pan);
  }
  Future<TypePAN> get typePan async {
    final typePan = await PreferencesHelper.read(PrefsKeys.typePan);
    if (typePan == null) throw Exception('typePan is null');

    return TypePAN(evalue: typePan);
  }

  Future<String> get baseUrl async {
    final baseUrl = await PreferencesHelper.read(PrefsKeys.resourcesUrl);
    if (baseUrl == null) throw Exception('baseUrl is null');
    final servletName = await PreferencesHelper.read(PrefsKeys.servletName);
    if (servletName == null) throw Exception('servletName is null');

    return '$baseUrl/$servletName';
  }

  Future<String> get terminalId async {
    final terminalId = await PreferencesHelper.read(PrefsKeys.terminalId);
    if (terminalId == null) throw Exception('terminalId is null');

    return terminalId;
  }

  @override
  Future<ListPopularResponse> listPopularRequest({
    required int count
  }) async {
    final listPopularRequest = ListPopularRequest(
      terminalId: await terminalId,
      version: _komplatVersion,
      // token: token,
      // clientInfo: ClientInfo(
      //   id: login!
      // ),
      filter: ListPopularRequestFilter(
        type: 1,
        count: count
      )
    );
    final psEripListPopularRequest = PsEripListPopularRequest(listPopularRequest);
    final wrapper = PsEripListPopularRequestWrapper(psEripListPopularRequest);
    return komplatApi.listPopularRequest(
      baseUrl: await baseUrl,
      body: wrapper,
    ).then((it) => it.psErip.response);
  }

  @override
  Future<GetPayListResponse> getPayListRequest({
    required int payCode,
    String? sessionId,
    List<AttrRecordRequest>? attrRecord,
    double? sum,
    int? currency,
    List<RequestProperty>? properties
  }) async {
    final getPayListRequest = GetPayListRequest(
      terminalId: await terminalId,
      version: _komplatVersion,
      pan: await pan,
      typePan: await typePan,
      // token: token,
      payCode: payCode,
      sessionId: sessionId,
      attrRecord: attrRecord,
      paySumma: sum != null ? GetPayListRequestPaySumma(
        evalue: sum,
        currency: currency
      ) : null,
      //properties: properties
    );
    final psEripGetPayListRequest = PsEripGetPayListRequest(getPayListRequest);
    final wrapper = PsEripGetPayListRequestWrapper(psEripGetPayListRequest);
    return komplatApi.getPayListRequest(
      baseUrl: await baseUrl,
      body: wrapper,
    ).then((it) => it.psErip.response);
  }

  @override
  Future<GetUserProfileResponse> getUserProfileRequest() async {
    final getUserProfileRequest = GetUserProfileRequest(
      terminalId: await terminalId,
      version: _shopVersion
    );
    final psEripGetUserProfileRequest = PsEripGetUserProfileRequest(getUserProfileRequest);
    final wrapper = PsEripGetUserProfileRequestWrapper(psEripGetUserProfileRequest);
    return komplatApi.getUserProfileRequest(
      baseUrl: await baseUrl,
      body: wrapper,
    ).then((it) => it.psErip.response);
  }

  @override
  Future<RunOperationResponse> runOperationRequest({
    required PayRecordResponse service,
    required List<AttrRecordRequest> attrs,
    required String kioskReceipt,
    List<RequestProperty>? properties
  }) async {
    final body = getRunOperationRequest(
      terminalId: await terminalId,
      pan: await pan,
      typePan: await typePan,
      attrs: attrs,
      service: service,
      kioskReceipt: kioskReceipt,
      properties: properties
    );
    final psEripRunOperationRequest = PsEripRunOperationRequest(body);
    final wrapper = PsEripRunOperationRequestWrapper(psEripRunOperationRequest);
    return komplatApi.runOperationRequest(
      baseUrl: await baseUrl,
      body: wrapper
    ).then((it) => it.psErip.response);
  }

  RunOperationRequest getRunOperationRequest({
    required String terminalId,
    required PAN pan,
    required TypePAN typePan,
    required List<AttrRecordRequest> attrs,
    required PayRecordResponse service,
    required String kioskReceipt,
    List<RequestProperty>? properties
  }) {
    final payRecordRequest = PayRecordRequest(
      code: service.code,
      //codeOut: service.codeOut,
      nameOut: service.name,
      recordId: paymentsCount + 1,
      summa: service.summa,
      currency: service.currency ?? AppConfig.defaultCurrency,
      sessionId: service.sessionId,
      attrRecord: attrs,
    );
    return RunOperationRequest(
      terminalId: terminalId,
      pan: pan,
      typePAN: typePan,
      version: _komplatVersion,
      lang: _psEripLang,
      // token: token,
      payDate: DateTime.now().toStringFormattedRunOperation(),
      // kioskReceipt: key.toString(),
      kioskReceipt: kioskReceipt,
      payRecord: [payRecordRequest],
      //properties: properties
    );
  }

  @override
  Future<OpenBasketResponse> openBasketRequest() async {
    final body = OpenBasketRequest(
      terminalId: await terminalId,
      version: _shopVersion,
    );
    final psEripOpenBasketRequest = PsEripOpenBasketRequest(body);
    final wrapper = PsEripOpenBasketRequestWrapper(psEripOpenBasketRequest);
    return komplatApi.openBasketRequest(
      baseUrl: await baseUrl,
      body: wrapper,
    ).then((it) => it.psErip.response);
  }

  @override
  Future<CloseBasketResponse> closeBasketRequest({
    required String barcode
  }) async {
    final body = CloseBasketRequest(
      terminalId: await terminalId,
      version: _shopVersion,
      barcode: barcode
    );
    final psEripCloseBasketRequest = PsEripCloseBasketRequest(body);
    final wrapper = PsEripCloseBasketRequestWrapper(psEripCloseBasketRequest);
    return komplatApi.closeBasketRequest(
      baseUrl: await baseUrl,
      body: wrapper,
    ).then((it) => it.psErip.response);
  }

  @override
  Future<ConfirmResponse> confirmRequest({
    required PayRecordResponse service,
    bool isCanceled = false
  }) async {
    final confirmRequestPayRecord = ConfirmRequestPayRecord(
      paymentID: service.paymentID,
      date: service.date,
      kioskReceipt: kioskReceipt,
      confirmCode: isCanceled ? 0 : 1,
      cancelReason: ''
    );
    final confirmRequest = ConfirmRequest(
      terminalId: await terminalId,
      version: _komplatVersion,
      pan: await pan,
      typePan: await typePan,
      payRecord: [confirmRequestPayRecord]
    );
    final psEripConfirmRequest = PsEripConfirmRequest(confirmRequest);
    final wrapper = PsEripConfirmRequestWrapper(psEripConfirmRequest);
    return komplatApi.confirmRequest(
      baseUrl: await baseUrl,
      body: wrapper,
    ).then((it) => it.psErip.response);
  }

  @override
  Future<SearchBasketResponse> searchBasket({
    required String barcode,
  }) async {
    final searchBasketRequest = SearchBasketRequest(
      terminalId: await terminalId,
      version: _shopVersion,
      barcode: barcode
    );
    final psEripSearchBasketRequest = PsEripSearchBasketRequest(searchBasketRequest);
    final wrapper = PsEripSearchBasketRequestWrapper(psEripSearchBasketRequest);
    return komplatApi.searchBasketRequest(
      baseUrl: await baseUrl,
      body: wrapper,
    ).then((it) => it.psErip.response);
  }

  @override
  Future<String> getIpAddress()
      => ipifyApi.getIpRequest().then((it) => it.ip);

  @override
  Future<CheckConnectResponse> checkConnectRequest({
    required String ipAddress
  }) async {
    final checkConnectRequest = CheckConnectRequest(
      terminalId: await terminalId,
      version: _shopVersion,
      ip: ipAddress
    );
    final psMtCheckConnectRequest = PsMtCheckConnectRequest(checkConnectRequest);
    final wrapper = PsMtCheckConnectRequestWrapper(psMtCheckConnectRequest);
    return mtApi.checkConnectionRequest(
      baseUrl: await baseUrl,
      body: wrapper
    ).then((it) => it.psMt.response);
  }

}