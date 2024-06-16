// ignore_for_file: always_put_required_named_parameters_first

import 'package:bpc_nkfo/utils/utils.dart';
import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';

import 'data.dart';

class FakeDataManager extends DataManager {
  FakeDataManager(Dio dio) : super(dio);

  Future<void> get _delay => Future<void>.delayed(const Duration(milliseconds: 200));

  @override
  Future<TokenResponse> tokenRequest(String login, String password) async {
    await _delay;
    token = 'testToken'; 
    return TokenResponse(
      token: TokenResponseToken(evalue: token, terminalId: 'testTerminal'),
      version: 1,
      key: 123,
      errorCode: 0
    );
  }

  @override
  Future<DeleteTokenResponse> deleteTokenRequest(String token) async {
    await _delay;
    return DeleteTokenResponse(
      version: 1,
      key: 123,
      errorCode: 0
    );
  }

  @override
  Future<InformationResponse> informationRequest() async {
    await _delay;
    final info = InformationResponse(
      fullName: 'fullName',
      shortName: 'shortName',
      address: 'address',
      mfo: 'mfo',
      accNum: 'accNum',
      unp: 'unp',
      fio: 'fio',
      post: 'post',
      basis: 'basis',
      usersCount: 9,
      confirmStatus: 1,
      supplierId: 123,
      version: 1,
      key: 123,
      errorCode: 0
    );
    informationResponse = info;
    return info;
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
    await _delay;
    return ClaimsListResponse(
      rowCount: 2,
      claims: [
        // Claim(
        //   id: 1,
        //   accNum: '1234',
        //   invoiceDate: '01.01.2021 12:22:22',
        //   dueDate: '10.12.2021 23:59:59',
        //   status: 2,
        //   fio: Fio(evalue: 'test test test'),
        //   sum: 12.3,
        //   paymentSum: 2,
        // ),
        // Claim(
        //   id: 2,
        //   accNum: '1234',
        //   invoiceDate: '02.01.2021 12:22:22',
        //   dueDate: '10.12.2021 23:59:59',
        //   status: 2,
        //   fio: Fio(evalue: 'test test test'),
        //   sum: 12.3,
        //   paymentSum: 2,
        // ),
      ],
      version: 1,
      key: 123,
      errorCode: 0
    );
  }

  @override
  Future<DeleteClaimResponse> deleteClaimRequest(int id) async {
    await _delay;
    return DeleteClaimResponse(
      version: 1,
      key: 123,
      errorCode: 0
    );
  }

  @override
  Future<AddClaimResponse> addClaimRequest(AddClaimRequest claim) async {
    await _delay;
    return AddClaimResponse(
      invoiceDate: '10.10.2022 12:12:22',
      claimId: AddClaimResponseClaimId(
        evalue: 123,
      ),
      version: 1,
      key: 123,
      errorCode: 0
    );
  }

  @override
  Future<SupplierStatusResponse> supplierStatusRequest() async {
    await _delay;
    return SupplierStatusResponse(
      eripStatus: 1,
      testModeStatus: 0,
      version: 1,
      key: 123,
      errorCode: 0
    );
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
    await _delay;
    return PaymentsListResponse(
      payments: [
        Payment(
          id: 1,
          accNum: '1234',
          fio: 'fio',
          paymentDate: '01.01.2022 12:22:22',
          paymentSum: 12.3,
          paymentStatus: 1,
          memDate: '01.01.2022 13:22:22',
          memNumber: '123',
          authorizationType: 'authorizationType'
        ),
        Payment(
          id: 2,
          accNum: '1234',
          fio: 'fio',
          paymentDate: '02.01.2022 12:22:22',
          paymentSum: 12.3,
          paymentStatus: 1,
          memDate: '01.01.2022 13:22:22',
          memNumber: '123',
          authorizationType: 'authorizationType'
        ),
      ],
      version: 1,
      key: 123,
      errorCode: 0
    );
  }

  @override
  Future<ServicesListResponse> servicesListRequest() async {
    await _delay;
    return ServicesListResponse(
      services: [
        Service(
          code: 1,
          codeRasvikom: 1,
          name: 'service 1 name'
        ),
        Service(
          code: 2,
          codeRasvikom: 2,
          name: 'service 2 name'
        ),
      ],
      version: 1,
      key: 123,
      errorCode: 0
    );
  }

  @override
  Future<AlgorithmListResponse> algorithmListRequest(int code) async {
    await _delay;
    return AlgorithmListResponse(
      algorithms: [],
      version: 1,
      key: 123,
      errorCode: 0
    );
  }

  @override
  Future loadServicesList() async {
    await _delay;
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