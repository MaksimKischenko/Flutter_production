import 'package:dio/dio.dart';
import 'package:isc_web_app/data/data_manager.dart';
import 'package:isc_web_app/models/models.dart';


import 'data.dart';

class FakeDataManager extends DataManager {
  FakeDataManager(Dio dio) : super(dio);

  final _delay = Future<void>.delayed(const Duration(seconds: 2));


  @override
  Future<MdomLoginResponse> loginRequest({
    String? login,
    String? password,
    int? code,
  }) async {
    await _delay;
    return const MdomLoginResponse(
      requestType: 'LoginResponse',
      token: MdomToken(
        evalue: 'fakeToken',
        terminalId: 'fakeTerminal',
        version: '1',
      ),
      errorCode: MdomErrorCode(
        evalue: 0,
      ),
    );
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
    await _delay;
    return ClaimsListResponse(
      claims: const [
        Claim(
          id: 1,
          accNum: '1',
          invoiceDate: '01.01.2021 12:22:22',
          dueDate: '10.12.2021 23:59:59',
          status: ClaimStatus.all,
          fio: 'TEST TESTOVICH_1',
          sum: 12.3,
          paymentSum: 2,
          qrCode: 'https://pay.raschet.by/#00020132370010by.raschet010310110124444444444445303933540571.005802BY5913UNP_1234567896007Belarus63040A6C"'
        ),
        Claim(
          id: 22,
          accNum: '2',
          invoiceDate: '02.01.2021 12:22:22',
          dueDate: '10.12.2021 23:59:59',
          status: ClaimStatus.overdue,
          fio: 'TEST TESTOVICH_2',
          sum: 12.3,
          paymentSum: 2,
          qrCode: 'https://pay.raschet.by/#00020132370010by.raschet010310110124444444444445303933540571.005802BY5913UNP_1234567896007Belarus63040A6C"'          
        ),
        Claim(
          id: 3,
          accNum: '3',
          invoiceDate: '02.01.2021 12:22:22',
          dueDate: '10.12.2021 23:59:59',
          status: ClaimStatus.fullyPaid,
          fio: 'TEST TESTOVICH_2',
          sum: 12.3,
          paymentSum: 2,
          qrCode: 'https://pay.raschet.by/#00020132370010by.raschet010310110124444444444445303933540571.005802BY5913UNP_1234567896007Belarus63040A6C"'          
        ),   
        Claim(
          id: 4,
          accNum: '4',
          invoiceDate: '02.01.2021 12:22:22',
          dueDate: '10.12.2021 23:59:59',
          status: ClaimStatus.unpaid,
          fio: 'TEST TESTOVICH_2',
          sum: 12.3,
          paymentSum: 2,
          qrCode: 'https://pay.raschet.by/#00020132370010by.raschet010310110124444444444445303933540571.005802BY5913UNP_1234567896007Belarus63040A6C"'          
        ),             
      ],
      version: 1,
      key: 123,
      errorCode: 0,
    );
  }
  @override
  Future<PaymentsListResponse> paymentListRequest(
      {required DateTime from,
      required DateTime to,
      required PaymentDateType dateType, 
      required PaymentStatus status,      
      String? accNum,
      int? claimId,
      int? count,
      int? lastPaymentId}) async {
    await _delay;
    return  PaymentsListResponse(
      payments: [
        PaymentISC(
          id: 1,
          accNum: '1234',
          fio: 'Тест_1',
          paymentDate: '01.01.2022 12:22:22',
          paymentSum: 12.3,
          status: PaymentStatus.all,
          memDate: '01.01.2022 13:22:22',
          memNumber: '123',
        ),
        PaymentISC(
          id: 2,
          accNum: 'Тест_2',
          fio: 'fio',
          paymentDate: '02.01.2022 12:22:22',
          paymentSum: 12.3,
          status: PaymentStatus.registered,
          memDate: '01.01.2022 13:22:22',
          memNumber: '123',
        ),
        PaymentISC(
          id: 3,
          accNum: 'Тест_3',
          fio: 'Тест_1',
          paymentDate: '01.01.2022 12:22:22',
          paymentSum: 12.3,
          status: PaymentStatus.reversalStarted,
          memDate: '01.01.2022 13:22:22',
          memNumber: '123',
        ),
        PaymentISC(
          id: 4,
          accNum: 'Тест_4',
          fio: 'fio',
          paymentDate: '02.01.2022 12:22:22',
          paymentSum: 12.3,
          status: PaymentStatus.successfullyReversed,
          memDate: '01.01.2022 13:22:22',
          memNumber: '123',
        ),
        PaymentISC(
          id: 5,
          accNum: '1234',
          fio: 'Тест_5',
          paymentDate: '01.01.2022 12:22:22',
          paymentSum: 12.3,
          status: PaymentStatus.registrationCanceled,
          memDate: '01.01.2022 13:22:22',
          memNumber: '123',
        ),
        PaymentISC(
          id: 6,
          accNum: 'Тест_6',
          fio: 'fio',
          paymentDate: '02.01.2022 12:22:22',
          paymentSum: 12.3,
          status: PaymentStatus.paid,
          memDate: '01.01.2022 13:22:22',
          memNumber: '123',
        ),  
        PaymentISC(
          id: 7,
          accNum: 'Тест_7',
          fio: 'fio',
          paymentDate: '02.01.2022 12:22:22',
          paymentSum: 12.3,
          status: PaymentStatus.reversalStarted,
          memDate: '01.01.2022 13:22:22',
          memNumber: '123',
        ),         
        PaymentISC(
          id: 8,
          accNum: '1234',
          fio: 'Тест_8',
          paymentDate: '01.01.2022 12:22:22',
          paymentSum: 12.3,
          status: PaymentStatus.successfullyReversed,
          memDate: '01.01.2022 13:22:22',
          memNumber: '123',
        ),
        PaymentISC(
          id: 9,
          accNum: 'Тест_9',
          fio: 'fio',
          paymentDate: '02.01.2022 12:22:22',
          paymentSum: 12.3,
          status: PaymentStatus.paid,
          memDate: '01.01.2022 13:22:22',
          memNumber: '123',
        ),  
        PaymentISC(
          id: 10,
          accNum: 'Тест_10',
          fio: 'fio',
          paymentDate: '02.01.2022 12:22:22',
          paymentSum: 12.3,
          status: PaymentStatus.reversalStarted,
          memDate: '01.01.2022 13:22:22',
          memNumber: '123',
        ),                       
      ],
      version: 1,
      key: 123,
      errorCode: 0,
    );
  }
  
  @override
  Future<RegisterPaymentOfClaimResponse> registerPaymentOfClaimRequest({required int claimId, required String memNumber, required DateTime memDate, required double paySum, required String account}) {
    throw UnimplementedError();
  }
  
  @override
  Future<AddClaimResponse> addClaimRequest(AddClaimRequest claim) {
    // TODO: implement addClaimRequest
    throw UnimplementedError();
  }
}
