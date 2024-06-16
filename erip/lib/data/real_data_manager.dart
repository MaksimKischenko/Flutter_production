// ignore_for_file: always_put_required_named_parameters_first

import 'package:bpc_nkfo/config.dart';
import 'package:bpc_nkfo/utils/utils.dart';
import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';

import 'data.dart';

class RealDataManager extends DataManager {
  RealDataManager(Dio dio) : super(dio);

  @override
  Future<TokenResponse> tokenRequest(String login, String password) {
    final tokenRequest = TokenRequest(
      login: TokenRequestLoginName(
        evalue: login,
        deviceType: AppConfig.deviceType
      ),
      password: password,
      version: version,
      key: key
    );
    final psTpOTokenRequest = PsTpOTokenRequest(tokenRequest);
    final wrapper = PsTpOTokenRequestWrapper(psTpOTokenRequest);
    return komplatApi.tokenRequest(wrapper)
      .then((it) {
        token = it.psTpO.response.token?.evalue ?? '';
        return it.psTpO.response;
      });
  }

  @override
  Future<DeleteTokenResponse> deleteTokenRequest(String token) async {
    final deleteTokenRequest = DeleteTokenRequest(token);
    final psTpODeleteTokenRequest = PsTpODeleteTokenRequest(deleteTokenRequest);
    final wrapper = PsTpODeleteTokenRequestWrapper(psTpODeleteTokenRequest);
    return komplatApi.deleteTokenRequest(wrapper)
      .then((it) => it.psTpO.response);
  }

  @override
  Future<InformationResponse> informationRequest() async {
    final informationRequest = InformationRequest(
      token: token,
      version: version,
      key: key
    );
    final psTpOInformationRequest = PsTpOInformationRequest(informationRequest);
    final wrapper = PsTpOInformationRequestWrapper(psTpOInformationRequest);
    return komplatApi.informationRequest(wrapper)
      .then((it) {
        informationResponse = it.psTpO.response;
        return it.psTpO.response;
      });
  }

  @override
  Future<ClaimsListResponse> claimsListRequest({
    required int code,
    int? status,
    required String from,
    required String to,
    String? accNum,
    RowCountClaims? rowCount
  }) async {
    final claimsListRequest = ClaimsListRequest(
      serviceCode: code,
      dateFrom: '$from 00:00:00',
      dateTo: '$to 23:59:59',
      accNum: accNum,
      status: status,
      rowCount: rowCount,
      token: token,
      version: version,
      key: key
    );
    final psTpOClaimsListRequest = PsTpOClaimsListRequest(claimsListRequest);
    final wrapper = PsTpOClaimsListRequestWrapper(psTpOClaimsListRequest);
    return komplatApi.claimsListRequest(wrapper)
      .then((it) => it.psTpO.response);
  }

  @override
  Future<DeleteClaimResponse> deleteClaimRequest(int id) async {
    final deleteClaimRequest = DeleteClaimRequest(
      claimId: id,
      token: token,
      version: version,
      key: key
    );
    final psTpODeleteClaimRequest = PsTpODeleteClaimRequest(deleteClaimRequest);
    final wrapper = PsTpODeleteClaimRequestWrapper(psTpODeleteClaimRequest);
    return komplatApi.deleteClaimRequest(wrapper)
      .then((it) => it.psTpO.response);
  }

  @override
  Future<AddClaimResponse> addClaimRequest(AddClaimRequest claim) async {
    final addClaimRequest = claim.copy(
      version: version,
      token: token,
      key: key
    );
    final psTpOAddClaimRequest = PsTpOAddClaimRequest(addClaimRequest);
    final wrapper = PsTpOAddClaimRequestWrapper(psTpOAddClaimRequest);
    return komplatApi.addClaimRequest(wrapper)
      .then((it) => it.psTpO.response);
  }

  @override
  Future<SupplierStatusResponse> supplierStatusRequest() async {
    final supplierStatusRequest = SupplierStatusRequest(
      version: version,
      token: token,
      key: key
    );
    final psTpOSupplierStatusRequest = PsTpOSupplierStatusRequest(supplierStatusRequest);
    final wrapper = PsTpOSupplierStatusRequestWrapper(psTpOSupplierStatusRequest);
    return komplatApi.supplierStatusRequest(wrapper)
      .then((it) => it.psTpO.response);
  }

  @override
  Future<PaymentsListResponse> paymentListRequest({
    required int serviceCode,
    required int dateType,
    required String from,
    required String to,
    String? accNum,
    int? status,
    int? claimId,
    RowCountPayments? rowCount
  }) async {
    int? lastPayment;
    if (accNum?.isNotEmpty ?? false) lastPayment = 1;
    final paymentsListRequest = PaymentsListRequest(
      dateType: dateType,
      dateFrom: '$from 00:00:00',
      dateTo: '$to 23:59:59',
      accNum: accNum,
      status: status,
      claimId: claimId,
      lastPayment: lastPayment,
      serviceCode: serviceCode,
      rowCount: rowCount,
      version: version,
      token: token,
      key: key
    );
    final psTpOPaymentsListRequest = PsTpOPaymentsListRequest(paymentsListRequest);
    final wrapper = PsTpOPaymentsListRequestWrapper(psTpOPaymentsListRequest);
    return komplatApi.paymentsListRequest(wrapper)
      .then((it) => it.psTpO.response);
  }

  @override
  Future<ServicesListResponse> servicesListRequest() async {
    final serviceListRequest = ServicesListRequest(
      version: version,
      token: token,
      key: key
    );
    final psTpOServiceListRequest = PsTpOServicesListRequest(serviceListRequest);
    final wrapper = PsTpOServicesListRequestWrapper(psTpOServiceListRequest);
    return komplatApi.servicesListRequest(wrapper)
      .then((it) => it.psTpO.response);
  }

  @override
  Future<AlgorithmListResponse> algorithmListRequest(int code) async {
    final algorithmListRequest = AlgorithmListRequest(code, token, version, key);
    final psTpOAlgorithmListRequest = PsTpOAlgorithmListRequest(algorithmListRequest);
    final wrapper = PsTpOAlgorithmListRequestWrapper(psTpOAlgorithmListRequest);
    return komplatApi.algorithmListRequest(wrapper)
      .then((it) => it.psTpO.response); 
  }

  @override
  Future loadServicesList() async {
    await servicesListRequest()
      .then((it) {
        if (it.errorCode == 0) {
          servicesList = it.services ?? [];
          currentService = servicesList.firstOrNull;
          currentDateFrom = DateTime.now().toStringFormatted();
          currentDateTo = DateTime.now().toStringFormatted();
        }
      });
    return Future<void>.value(null);
  }
}