import 'package:bpc/models/models.dart';
import 'package:dio/dio.dart';

import 'data.dart';

class FakeDataManager extends DataManager {
  FakeDataManager(Dio dio) : super(dio);

  Future<void> get _delay =>
      Future<void>.delayed(const Duration(milliseconds: 200));

  @override
  Future<InformationResponse> informationRequest() async {
    await _delay;
    final info = InformationResponse(
      fullName: 'fullName',
      shortName: 'shortName',
      address: 'address',
      mfo: 'mfo',
      accNum: 'accNum',
      unp: 'keke',
      fio: 'fio',
      post: 'post',
      basis: 'basis',
      usersCount: 9,
      confirmStatus: 1,
      supplierId: 123,
      version: 1,
      key: 123,
      errorCode: 0,
    );
    informationResponse = info;
    return info;
  }

  @override
  Future<ClaimsListResponse> claimsListRequest({
    required Service service,
    required ClaimStatus status,
    required DateTime from,
    required DateTime to,
    int? claimId,
    String? accNum,
    int? count,
    int? lastClaimId,
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
      errorCode: 0,
    );
  }

  @override
  Future<DeleteClaimResponse> deleteClaimRequest(int id) async {
    await _delay;
    return DeleteClaimResponse(
      version: 1,
      key: 123,
      errorCode: 0,
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
      errorCode: 0,
    );
  }

  @override
  Future<PaymentsListResponse> paymentListRequest({
    required Service service,
    required PaymentStatus status,
    required PaymentDateType dateType,
    required DateTime from,
    required DateTime to,
    String? accNum,
    int? claimId,
    int? count,
    int? lastPaymentId,
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
          status: PaymentStatus.registered,
          memDate: '01.01.2022 13:22:22',
          memNumber: '123',
          authorizationType: 'authorizationType',
        ),
        Payment(
          id: 2,
          accNum: '1234',
          fio: 'fio',
          paymentDate: '02.01.2022 12:22:22',
          paymentSum: 12.3,
          status: PaymentStatus.registered,
          memDate: '01.01.2022 13:22:22',
          memNumber: '123',
          authorizationType: 'authorizationType',
        ),
      ],
      version: 1,
      key: 123,
      errorCode: 0,
    );
  }

  @override
  Future<ServicesListResponse> servicesListRequest() async {
    await _delay;
    return ServicesListResponse(
      services: [
        Service(code: 1, codeRasvikom: 1, name: 'service 1 name'),
        Service(code: 2, codeRasvikom: 2, name: 'service 2 name'),
      ],
      version: 1,
      key: 123,
      errorCode: 0,
    );
  }

  @override
  Future<AlgorithmListResponse> algorithmListRequest(int code) async {
    await _delay;
    // TODO: add fake algorithms
    return AlgorithmListResponse(
      algorithms: [],
      version: 1,
      key: 123,
      errorCode: 0,
    );
  }

  @override
  Future loadServicesList() async {
    await _delay;
    await servicesListRequest().then((it) {
      if (it.errorCode == 0) {
        servicesList = it.services ?? [];
      }
    });
    return Future<void>.value(null);
  }

  @override
  Future<MdomLoginResponse> loginRequest({
    String? login,
    String? fio,
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
  Future<MdomCreateResponse> createRequest({
    required String login,
    required String fio,
    required String password,
    String? phone,
    bool isSendCodeSMS = false,
    String? keyRegistration,
  }) async {
    await _delay;
    return const MdomCreateResponse(
      requestType: 'CreateResponse',
      token: MdomToken(
        evalue: 'fakeToken',
      ),
      errorCode: MdomErrorCode(
        evalue: 1,
        errorText: 'unimplemented',
      ),
    );
  }

  @override
  Future<MdomEditUserResponse> editUserRequest({
    MdomRequestParams? userParams,
    MdomEditUserRequestProducts? products,
    MdomEditUserRequestTerminals? terminals,
    EditUserRequestNeedChangePassword? needChangePassword,
  }) async {
    await _delay;
    return const MdomEditUserResponse(
      requestType: 'EditUserResponse',
      token: MdomToken(
        evalue: 'fakeToken',
      ),
      errorCode: MdomErrorCode(
        evalue: 1,
        errorText: 'unimplemented',
      ),
    );
  }

  @override
  Future<EntityPollsListResponse> pollsListRequest({
    String? topic,
    PollStatus? status,
    required DateTime stopDateFrom,
    required DateTime stopDateTo,
    int? count,
    int? lastPollId,
  }) async {
    await _delay;
    return const EntityPollsListResponse(
      version: 1,
      keyRequest: 123,
      errorCode: 1,
      errorText: 'unimplemented',
    );
  }

  @override
  Future<AddPollResponse> addPollRequest({
    required String topic,
    required DateTime startDate,
    required DateTime stopDate,
    String? url,
    required bool anonymous,
    bool publish = false,
    List<PollQuestionEdit>? questions,
  }) async {
    await _delay;
    return const AddPollResponse(
      version: 1,
      keyRequest: 123,
      errorCode: 0,
    );
  }

  @override
  Future<EditPollResponse> editPollRequest({
    required int id,
    String? topic,
    DateTime? startDate,
    DateTime? stopDate,
    String? url,
    bool? anonymous,
    bool? publish,
    List<PollQuestionEdit>? questions,
  }) async {
    await _delay;
    return const EditPollResponse(
      version: 1,
      keyRequest: 123,
      errorCode: 0,
    );
  }

  @override
  Future<DeletePollResponse> deletePollRequest({
    required int id,
  }) async {
    await _delay;
    return const DeletePollResponse(
      version: 1,
      keyRequest: 123,
      errorCode: 0,
    );
  }

  @override
  Future<NotificationPollResponse> notificationPollRequest({
    required int id,
    required String message,
  }) async {
    await _delay;
    return const NotificationPollResponse(
      version: 1,
      keyRequest: 123,
      errorCode: 0,
    );
  }

  @override
  Future<CancelPollResponse> cancelPollRequest({
    required int id,
  }) async {
    await _delay;
    return const CancelPollResponse(
      version: 1,
      keyRequest: 123,
      errorCode: 0,
    );
  }

  @override
  Future<PollMembersListResponse> pollMembersListRequest({
    required int id,
  }) async {
    await _delay;
    return const PollMembersListResponse(
      version: 1,
      keyRequest: 123,
      errorCode: 0,
    );
  }

  @override
  Future<QuestionAnswersListResponse> questionAnswersListRequest({
    required int pollId,
    int? questionId,
  }) async {
    await _delay;

    return const QuestionAnswersListResponse(
      version: 1,
      keyRequest: 1234,
      errorCode: 0,
      questions: [
        QuestionAnswersListQuestion(
          idx: 1,
          text: 'Установить членский взнос в размере 20 р.?',
          answers: [
            QuestionAnswersListQuestionAnswer(
              evalue: PollAnswer.abstain,
              clientAccount: '23509235',
              fio: 'Говорушко Елена Сергеевна',
            ),
            QuestionAnswersListQuestionAnswer(
              evalue: PollAnswer.yes,
              clientAccount: '49683069',
              fio: 'ФИО собственника',
            ),
            QuestionAnswersListQuestionAnswer(
              evalue: PollAnswer.no,
              clientAccount: '230942349',
              fio: 'Говорушко Елена Сергеевна',
            ),
            QuestionAnswersListQuestionAnswer(
              evalue: PollAnswer.abstain,
              clientAccount: '23509235',
              fio: 'ФИО собственника',
            ),
            QuestionAnswersListQuestionAnswer(
              evalue: PollAnswer.yes,
              clientAccount: '49683069',
              fio: 'Ягелончик Аркадий Дмитиевич',
            ),
            QuestionAnswersListQuestionAnswer(
              evalue: PollAnswer.no,
              clientAccount: '230942349',
              fio: 'Говорушко Елена Сергеевна',
            ),
            QuestionAnswersListQuestionAnswer(
              evalue: PollAnswer.abstain,
              clientAccount: '23509235',
              fio: 'Ягелончик Аркадий Дмитиевич',
            ),
            QuestionAnswersListQuestionAnswer(
              evalue: PollAnswer.yes,
              clientAccount: '49683069',
              fio: 'Говорушко Елена Сергеевна',
            ),
            QuestionAnswersListQuestionAnswer(
              evalue: PollAnswer.no,
              clientAccount: '230942349',
              fio: 'ФИО собственника',
            ),
            QuestionAnswersListQuestionAnswer(
              evalue: PollAnswer.abstain,
              clientAccount: '23509235',
              fio: 'ФИО собственника',
            ),
            QuestionAnswersListQuestionAnswer(
              evalue: PollAnswer.yes,
              clientAccount: '49683069',
              fio: 'Говорушко Елена Сергеевна',
            ),
            QuestionAnswersListQuestionAnswer(
              evalue: PollAnswer.no,
              clientAccount: '230942349',
              fio: 'Ягелончик Аркадий Дмитиевич',
            ),
            QuestionAnswersListQuestionAnswer(
              evalue: PollAnswer.abstain,
              clientAccount: '23509235',
              fio: 'FIO 1',
            ),
            QuestionAnswersListQuestionAnswer(
              evalue: PollAnswer.yes,
              clientAccount: '49683069',
              fio: 'Ягелончик Аркадий Дмитиевич',
            ),
            QuestionAnswersListQuestionAnswer(
              evalue: PollAnswer.no,
              clientAccount: '230942349',
              fio: 'Говорушко Елена Сергеевна',
            ),
          ],
        ),
      ],
    );
  }
}
