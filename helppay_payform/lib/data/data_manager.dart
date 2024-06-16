import 'package:dio/dio.dart';
import 'package:helppay_payform_app/config.dart';
import 'package:helppay_payform_app/models/dynamic_config.dart';
import 'package:helppay_payform_app/utils/date_helper.dart';
import 'package:helppay_payform_app/utils/loger.dart';

import 'data.dart';

void _log(dynamic message) => Logger.helpPayLog(message, name: 'data_manager');

class DataManager {
  final KomplatApi _komplatApi;

  DataManager({
    required Dio dio,
    required DynamicConfig config,
  }) : _komplatApi = KomplatApi(dio, baseUrl: config.apiUrl);

  int get key => DateTime.now().millisecondsSinceEpoch;

  String? login;
  String? getPaymentsToken;
  String initHelppayToken = '';
  String password = '';
  String deviceType = '';
  String confirmUri = '';
  String returnUri = '';
  String payerId = '';
  double maxAmount = 0;
  String mode = '';
  List<Payment> payments = [];
  final List<Service?> nodesRouteMap = [];

  Future<PaymentsResponse> paymentsRequest(String? token) =>
      _komplatApi.paymentsRequest(token ?? '');

  Future<ListPopularResponse> listPopularRequest({required int count}) =>
      _komplatApi.listPopularRequest(
          token: getPaymentsToken ?? '', count: count);

  Future<DeletePaymentResponse> deletePaymentResponse(Payment payment) =>
      _komplatApi.deletePaymentRequest(
          token: getPaymentsToken ?? '', id: payment.id);

  Future<GetPayListFiltersResponse> getPayListFiltersRequest() =>
      _komplatApi.getPayListFiltersRequest(token: getPaymentsToken ?? '');

  Future<GetPayListResponse> getPayListRequest({
    required int payCode,
    required int diType,
    List<FilterAttrRecord>? filters,
    String? sessionId,
    List<AttrRecordRequest>? attrRecord,
    double? sum,
    int? currency,
    List<RequestProperty>? properties,
  }) {
    final body = GetPayListRequest(
        payCode: GetPayListRequestPayCode(evalue: payCode),
        diType: diType,
        filter: filters != null
            ? GetPayListRequestFilter(attrRecords: filters)
            : null,
        sessionId: sessionId,
        attrRecord: attrRecord,
        paySumma: sum != null
            ? GetPayListRequestPaySumma(evalue: sum, currency: currency)
            : null,
        properties: properties);
    return _komplatApi.getPayListRequest(
        token: getPaymentsToken ?? '', body: body);
  }

  Future<RunOperationResponse> runOperationRequest(
      {required PayRecordResponse service,
      required List<AttrRecordRequest> attrs,
      List<RequestProperty>? properties}) {
    final body = getRunOperationRequest(
        attrs: attrs, service: service, properties: properties);
    return _komplatApi.runOperationRequest(
        token: getPaymentsToken ?? '', body: body);
  }

  RunOperationRequest getRunOperationRequest(
      {required List<AttrRecordRequest> attrs,
      required PayRecordResponse service,
      List<RequestProperty>? properties}) {
    final payRecordRequest = PayRecordRequest(
      code: service.code,
      codeOut: service.codeOut,
      nameOut: service.name,
      summa: service.summa,
      currency: service.currency ?? AppConfig.defaultCurrency,
      sessionId: service.sessionId,
      attrRecord: attrs,
    );
    return RunOperationRequest(
        payDate: DateTime.now().toStringFormattedRunOperation(),
        kioskReceipt: key.toString(),
        payRecord: payRecordRequest,
        properties: properties);
  }

  Future<GetCheckDuplicateResponse> getCheckDuplicateRequest({
    required int paymentId,
  }) =>
      _komplatApi.getCheckDuplicateRequest(
          token: getPaymentsToken ?? '', paymentId: paymentId);

  Future<ConfirmDebetResponse> confirmDebetRequest() =>
      _komplatApi.confirmDebetRequest(token: getPaymentsToken ?? '');

  Future<InitHelpPayResponse> initHelpPayRequest(
      int? nodeId, int? nodeType) async {
    String? mode = await PreferencesHelper.getMode();
    _log('REQUEST MODE - $mode');
    _log('nodeType  - $nodeType');

    final initHelppayRequest = InitHelpPayRequest(
      password: password,
      loginName: LoginName(value: login ?? '', deviceType: deviceType),
      mode: ((nodeType ?? 2) == 2 && mode == 'NODE')
          ? mode ?? 'DICT'
          : 'DICT', //TODO use DICT or NODE for different list visualisation
      node: (nodeType ?? 2) == 2 && mode == 'NODE' ? nodeId ?? 0 : null,
      confirmURI: confirmUri,
      returnURI: returnUri,
      payer: Payer(payerId: payerId, maxAmount: maxAmount),
    );
    final psHelppayRequest = PSHelpPayRequest(initHelppayRequest);
    final wrapper = InitHelpPayRequestWrapper(psHelppayRequest);
    return _komplatApi.initHelppayRequest(wrapper).then(
          (it) =>
              it.psHelppay.response ??
              InitHelpPayResponse(
                sessionToken: '',
                servicesWrapper: ServiceWrapper(services: []),
                errorCode: -1,
              ),
        );
  }

  Future<DeleteHelpPayResponse> deleteHelppaySessionRequest() async {
    final deleteHelppaySessionRequest = DeleteHelpPayRequest(
        login: login ?? '', password: password, token: initHelppayToken);
    final psHelppayRequest =
        PSHelpPayDeleteRequest(deleteHelppaySessionRequest);
    final wrapper = DeleteHelpPayRequestWrapper(psHelppayRequest);
    return _komplatApi.deleteHelppaySessionRequest(wrapper).then((it) =>
        it.psHelppay?.response ??
        DeleteHelpPayResponse(errorCode: 0, errorText: ''));
  }
}
