import 'package:dio/dio.dart';
import 'package:isc_web_app/data/data_manager.dart';
import 'package:isc_web_app/models/models.dart';
import 'package:isc_web_app/utils/date_helper.dart';


import 'data.dart';


class RealDataManager extends DataManager {
  RealDataManager(Dio dio) : super(dio);


  @override
  Future<MdomLoginResponse> loginRequest({
    String? login,
    String? fio,
    String? password,
    int? code,
  }) async {
    late MdomLoginRequest loginRequest;
      loginRequest = MdomLoginRequest(
        requestType: 'Login', 
        terminalId: 'Login',
        version: '1',
        login: MdomLogin(
          evalue: login ?? '',
          password: password ?? '',
          deviceType: 'WEB'
        ),
      );

    final wrapper = MdomLoginRequestWrapper(loginRequest);
    return komplatISCApi.loginRequest(wrapper).then((it) => it.userResponse);
  }


  @override
  Future<ClaimsListResponse> claimsListRequest({
    required DateTime from,
    required DateTime to,
    required ClaimStatus status,
    int? claimId,
    String? accNum,
    int? count,
    int? lastClaimId,
  }) async {
    final claimsListRequest = ClaimsListRequest(
      version: version, 
      key: key,
      token: token,
      terminalId: terminalId,
      serviceCode: 101, 
      dateFrom: '${from.toStringFormatted()} 00:00:00',
      dateTo: '${to.toStringFormatted()} 23:59:59',
      accNum: accNum,
      status: status, 
      rowCount: RowCount(
        evalue: count ?? 0, 
        claimId: lastClaimId,
      ),
    );
    final psTpOClaimsListRequest = PsTpOClaimsListRequest(claimsListRequest);
    final wrapper = PsTpOClaimsListRequestWrapper(psTpOClaimsListRequest);
    return komplatISCApi
        .claimsListRequest(wrapper)
        .then((it) => it.psTpO.response);
  }

  @override
  Future<AddClaimResponse> addClaimRequest(AddClaimRequest claim) async {
    final addClaimRequest = claim.copyWith(
      version: version,
      key: key,
      token: token,
      terminalId: terminalId,
    );
    final psTpOAddClaimRequest = PsTpOAddClaimRequest(addClaimRequest);
    final wrapper = PsTpOAddClaimRequestWrapper(psTpOAddClaimRequest);
    return komplatISCApi
        .addClaimRequest(wrapper)
        .then((it) => it.psTpO.response);
  }

  @override
  Future<PaymentsListResponse> paymentListRequest({
    required DateTime from,
    required DateTime to,
    required PaymentDateType dateType, 
    required PaymentStatus status,    
    String? accNum,
    int? claimId,
    int? count,
    int? lastPaymentId,
  }) async {
    int? lastPayment;
    //if (accNum?.isNotEmpty ?? false) lastPayment = 1;
    final paymentsListRequest = PaymentsListRequest(
      version: version,
      key: key,
      token: token,
      terminalId: terminalId,
      dateType: dateType, 
      dateFrom: '${from.toStringFormatted()} 00:00:00',
      dateTo: '${to.toStringFormatted()} 23:59:59',
      accNum: accNum,
      status: status, 
      lastPayment: lastPayment,
      serviceCode: 101, 
      rowCount: RowCountPayments(
        evalue: count ?? 0, 
        paymentId: lastPaymentId,
      ),
    );
    final psTpOPaymentsListRequest =
        PsTpOPaymentsListRequest(paymentsListRequest);
    final wrapper = PsTpOPaymentsListRequestWrapper(psTpOPaymentsListRequest);
    return komplatISCApi
        .paymentsListRequest(wrapper)
        .then((it) => it.psTpO.response);
  }
  
  @override
  Future<RegisterPaymentOfClaimResponse> registerPaymentOfClaimRequest({
    required int claimId, 
    required String memNumber, 
    required DateTime memDate, 
    required double paySum, 
    required String account
  }) async {
   
    final registerPaymentOfClaimRequest = RegisterPaymentOfClaimRequest(
      claimId: claimId,
      paySum: paySum,
      memDate: '${memDate.toStringFormatted()} 00:00:00',
      memNumber: memNumber,
      account: account,
      version: version,
      key: key,
      token: token,
    );
    final psTpORegisterPaymentOfClaimRequest =
        PsTpORegisterPaymentClaimRequest(registerPaymentOfClaimRequest);
    final wrapper = PsTpORegisterPaymentClaimRequestWrapper(psTpORegisterPaymentOfClaimRequest);
    return komplatISCApi.registerPaymentClaimRequest(wrapper)
        .then((it) => it.psTpO.response);
  }
}
