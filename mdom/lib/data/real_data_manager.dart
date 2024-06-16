import 'package:bpc/config.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/utils/loger.dart';
import 'package:bpc/utils/utils.dart';
import 'package:dio/dio.dart';

import 'data.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'real_data_manager');

class RealDataManager extends DataManager {
  RealDataManager(Dio dio) : super(dio);

  @override
  Future<InformationResponse> informationRequest() async {
    final informationRequest = InformationRequest(
      version: version,
      key: key,
      token: token,
      terminalId: terminanlId,
    );
    final psTpOInformationRequest = PsTpOInformationRequest(informationRequest);
    final wrapper = PsTpOInformationRequestWrapper(psTpOInformationRequest);
    return komplatApi.informationRequest(wrapper).then((it) {
      informationResponse = it.psTpO.response;
      return it.psTpO.response;
    });
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
    final claimsListRequest = ClaimsListRequest(
      version: version,
      key: key,
      token: token,
      terminalId: terminanlId,
      serviceCode: service.code,
      dateFrom: '${from.toStringFormatted()} 00:00:00',
      dateTo: '${to.toStringFormatted()} 23:59:59',
      claimId: claimId,
      accNum: accNum,
      status: status,
      rowCount: RowCountClaims(
        evalue: count ?? AppConfig.claimsListLoadCount,
        claimId: lastClaimId,
      ),
    );
    final psTpOClaimsListRequest = PsTpOClaimsListRequest(claimsListRequest);
    final wrapper = PsTpOClaimsListRequestWrapper(psTpOClaimsListRequest);
    return komplatApi
        .claimsListRequest(wrapper)
        .then((it) => it.psTpO.response);
  }

  @override
  Future<DeleteClaimResponse> deleteClaimRequest(int id) async {
    final deleteClaimRequest = DeleteClaimRequest(
      version: version,
      key: key,
      token: token,
      terminalId: terminanlId,
      claimId: id,
    );
    final psTpODeleteClaimRequest = PsTpODeleteClaimRequest(deleteClaimRequest);
    final wrapper = PsTpODeleteClaimRequestWrapper(psTpODeleteClaimRequest);
    return komplatApi
        .deleteClaimRequest(wrapper)
        .then((it) => it.psTpO.response);
  }

  @override
  Future<AddClaimResponse> addClaimRequest(AddClaimRequest claim) async {
    final addClaimRequest = claim.copy(
      version: version,
      key: key,
      token: token,
      terminalId: terminanlId,
    );
    final psTpOAddClaimRequest = PsTpOAddClaimRequest(addClaimRequest);
    final wrapper = PsTpOAddClaimRequestWrapper(psTpOAddClaimRequest);
    return komplatApi.addClaimRequest(wrapper).then(
          (it) => it.psTpO.response,
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
    int? lastPayment;
    if (accNum?.isNotEmpty ?? false) lastPayment = 1;
    final paymentsListRequest = PaymentsListRequest(
      version: version,
      key: key,
      token: token,
      terminalId: terminanlId,
      dateType: dateType,
      dateFrom: '${from.toStringFormatted()} 00:00:00',
      dateTo: '${to.toStringFormatted()} 23:59:59',
      accNum: accNum,
      status: status,
      claimId: claimId,
      lastPayment: lastPayment,
      serviceCode: service.code,
      rowCount: RowCountPayments(
        evalue: count ?? AppConfig.paymentsListLoadCount,
        paymentId: lastPaymentId,
      ),
    );
    final psTpOPaymentsListRequest =
        PsTpOPaymentsListRequest(paymentsListRequest);
    final wrapper = PsTpOPaymentsListRequestWrapper(psTpOPaymentsListRequest);
    return komplatApi
        .paymentsListRequest(wrapper)
        .then((it) => it.psTpO.response);
  }

  @override
  Future<ServicesListResponse> servicesListRequest() async {
    final serviceListRequest = ServicesListRequest(
      version: version,
      key: key,
      token: token,
      terminalId: terminanlId,
    );
    final psTpOServiceListRequest =
        PsTpOServicesListRequest(serviceListRequest);
    final wrapper = PsTpOServicesListRequestWrapper(psTpOServiceListRequest);
    return komplatApi
        .servicesListRequest(wrapper)
        .then((it) => it.psTpO.response);
  }

  @override
  Future<AlgorithmListResponse> algorithmListRequest(int code) async {
    final algorithmListRequest = AlgorithmListRequest(
      version: version,
      key: key,
      token: token,
      terminalId: terminanlId,
      serviceCode: code,
    );
    final psTpOAlgorithmListRequest =
        PsTpOAlgorithmListRequest(algorithmListRequest);
    final wrapper = PsTpOAlgorithmListRequestWrapper(psTpOAlgorithmListRequest);
    return komplatApi
        .algorithmListRequest(wrapper)
        .then((it) => it.psTpO.response);
  }

  @override
  Future<void> loadServicesList() async {
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
  }) {
    MdomLoginRequest loginRequest;
    if (login != null && password != null) {
      // auth with login
      loginRequest = MdomLoginRequest(
        login: MdomLogin(
          evalue: login,
          fio: fio ?? '',
          password: password,
          deviceType: AppConfig.deviceType,
        ),
      );
    } else {
      // auth with token, code and terminalId
      loginRequest = MdomLoginRequest(
        tokenRecord: MdomTokenRecord(
          evalue: token,
          sendCode: code!,
          terminalId: terminanlId,
        ),
      );
    }
    final wrapper = MdomLoginRequestWrapper(loginRequest);
    return mdomApi.loginRequest(wrapper).then((it) => it.userResponse);
  }

  @override
  Future<MdomCreateResponse> createRequest({
    required String login,
    required String fio,
    required String password,
    String? phone,
    bool isSendCodeSMS = false,
    String? keyRegistration,
  }) {
    final createRequest = MdomCreateRequest(
        login: MdomLogin(
          evalue: login,
          fio: fio,
          password: password,
          deviceType: AppConfig.deviceType,
        ),
        isSendCodeSMS: MdomCreateRequestIsSendCodeSMS(
          evalue: isSendCodeSMS ? 1 : null,
          phone: isSendCodeSMS ? phone : null,
        ),
        isSendCodeEMail: !isSendCodeSMS ? 1 : null,
        isOrganization: MdomCreateUserIsOrganization(
          evalue: 1,
          keyRegistration: keyRegistration,
        ));
    final wrapper = MdomCreateRequestWrapper(createRequest);
    return mdomApi.createRequest(wrapper).then((it) {
      return it.userResponse;
    });
  }

  @override
  Future<MdomEditUserResponse> editUserRequest(
      {MdomRequestParams? userParams,
      MdomEditUserRequestProducts? products,
      MdomEditUserRequestTerminals? terminals,
      EditUserRequestNeedChangePassword? needChangePassword}) {
    final editUserRequest = MdomEditUserRequest(
      terminalId: terminanlId,
      version: versionReg,
      token: token,
      params: userParams,
      needChangePassword: needChangePassword,
      products: products,
      terminals: terminals,
    );
    final wrapper = MdomEditUserRequestWrapper(editUserRequest);
    return mdomApi.editUserRequest(wrapper).then((it) => it.userResponse);
  }

  @override
  Future<EntityPollsListResponse> pollsListRequest({
    String? topic,
    PollStatus? status,
    required DateTime stopDateFrom,
    required DateTime stopDateTo,
    int? count,
    int? lastPollId,
  }) {
    final pollsListRequest = EntityPollsListRequest(
        terminalId:
            MdomTpIntTerminalId(evalue: 'terminal', password: 'password'),
        version: mdomTpIntVersion,
        keyRequest: key,
        // TODO
        // lang: await lang,
        token: token,
        topic: topic,
        status: status ?? PollStatus.all,
        stopDateFrom: '${stopDateFrom.toStringFormatted()} 00:00:00',
        stopDateTo: '${stopDateTo.toStringFormatted()} 23:59:59',
        rowCount: EntityPollsListRequestRowCount(
          evalue: count ?? AppConfig.pollsListRequestLoadCount,
          pollId: lastPollId,
        ));
    final mdomTpIntEntityPollsListRequest =
        MdomTpIntEntityPollsListRequest(pollsListRequest);
    final wrapper =
        MdomTpIntEntityPollsListRequestWrapper(mdomTpIntEntityPollsListRequest);
    return mdomTpIntApi
        .pollsListRequest(wrapper)
        .then((it) => it.psTpInt.response);
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
  }) {
    final addPollRequest = AddPollRequest(
      terminalId: MdomTpIntTerminalId(
        evalue: 'terminal',
        password: 'password',
      ),
      version: mdomTpIntVersion,
      keyRequest: key,
      // TODO
      // lang: await lang,
      token: token,
      topic: topic,
      startDate: startDate.toStringFormattedWithTime(),
      stopDate: stopDate.toStringFormattedWithTime(),
      url: url,
      anonymous: anonymous ? 1 : 0,
      publish: publish ? 1 : 0,
      questions: questions,
    );
    final mdomTpIntAddPollRequest = MdomTpIntAddPollRequest(addPollRequest);
    final wrapper = MdomTpIntAddPollRequestWrapper(mdomTpIntAddPollRequest);
    return mdomTpIntApi
        .addPollRequest(wrapper)
        .then((it) => it.psTpInt.response);
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
  }) {
    final editPollRequest = EditPollRequest(
      terminalId: MdomTpIntTerminalId(
        evalue: 'terminal',
        password: 'password',
      ),
      version: mdomTpIntVersion,
      keyRequest: key,
      // TODO
      // lang: await lang,
      token: token,
      pollId: id,
      topic: topic,
      startDate: startDate?.toStringFormattedWithTime(),
      stopDate: stopDate?.toStringFormattedWithTime(),
      url: url,
      anonymous: anonymous == null
          ? null
          : anonymous
              ? 1
              : 0,
      publish: publish == null
          ? null
          : publish
              ? 1
              : 0,
      questions: questions,
    );
    final mdomTpIntEditPollRequest = MdomTpIntEditPollRequest(editPollRequest);
    final wrapper = MdomTpIntEditPollRequestWrapper(mdomTpIntEditPollRequest);
    return mdomTpIntApi
        .editPollRequest(wrapper)
        .then((it) => it.psTpInt.response);
  }

  @override
  Future<DeletePollResponse> deletePollRequest({
    required int id,
  }) {
    final deletePollRequest = DeletePollRequest(
      terminalId: MdomTpIntTerminalId(
        evalue: 'terminal',
        password: 'password',
      ),
      version: mdomTpIntVersion,
      keyRequest: key,
      // TODO
      // lang: await lang,
      token: token,
      pollId: id,
    );
    final mdomTpIntDeletePollRequest =
        MdomTpIntDeletePollRequest(deletePollRequest);
    final wrapper =
        MdomTpIntDeletePollRequestWrapper(mdomTpIntDeletePollRequest);
    return mdomTpIntApi
        .deletePollRequest(wrapper)
        .then((it) => it.psTpInt.response);
  }

  @override
  Future<NotificationPollResponse> notificationPollRequest({
    required int id,
    required String message,
  }) {
    final notificationPollRequest = NotificationPollRequest(
      terminalId: MdomTpIntTerminalId(evalue: 'terminal', password: 'password'),
      version: mdomTpIntVersion,
      keyRequest: key,
      // TODO
      // lang: await lang,
      token: token,
      pollId: id,
      message: message,
    );
    final mdomTpIntNotificationPollRequest =
        MdomTpIntNotificationPollRequest(notificationPollRequest);
    final wrapper = MdomTpIntNotificationPollRequestWrapper(
        mdomTpIntNotificationPollRequest);
    return mdomTpIntApi
        .notificationPollRequest(wrapper)
        .then((it) => it.psTpInt.response);
  }

  @override
  Future<CancelPollResponse> cancelPollRequest({
    required int id,
  }) {
    final cancelPollRequest = CancelPollRequest(
      terminalId: MdomTpIntTerminalId(
        evalue: 'terminal',
        password: 'password',
      ),
      version: mdomTpIntVersion,
      keyRequest: key,
      // TODO
      // lang: await lang,
      token: token,
      pollId: id,
    );
    final mdomTpIntCancelPollRequest =
        MdomTpIntCancelPollRequest(cancelPollRequest);
    final wrapper =
        MdomTpIntCancelPollRequestWrapper(mdomTpIntCancelPollRequest);
    return mdomTpIntApi
        .cancelPollRequest(wrapper)
        .then((it) => it.psTpInt.response);
  }

  @override
  Future<PollMembersListResponse> pollMembersListRequest({
    required int id,
  }) {
    final pollMembersListRequst = PollMembersListRequest(
      terminalId: MdomTpIntTerminalId(evalue: 'terminal', password: 'password'),
      version: mdomTpIntVersion,
      keyRequest: key,
      // TODO
      // lang: await lang,
      token: token,
      pollId: id,
    );
    final mdomTpIntPollMembersListRequest =
        MdomTpIntPollMembersListRequest(pollMembersListRequst);
    final wrapper =
        MdomTpIntPollMembersListRequestWrapper(mdomTpIntPollMembersListRequest);
    return mdomTpIntApi
        .pollMembersListRequest(wrapper)
        .then((it) => it.psTpInt.response);
  }

  @override
  Future<QuestionAnswersListResponse> questionAnswersListRequest({
    required int pollId,
    int? questionId,
  }) async {
    final questionAnswersListRequest = QuestionAnswersListRequest(
      terminalId: MdomTpIntTerminalId(
        evalue: 'terminal',
        password: 'password',
      ),
      version: mdomTpIntVersion,
      keyRequest: key,
      // TODO
      // lang: await lang,
      token: token,
      pollId: pollId,
      questionId: questionId,
    );
    final mdomTpIntQuestionAnswersListRequest =
        MdomTpIntQuestionAnswersListRequest(questionAnswersListRequest);
    final wrapper = MdomTpIntQuestionAnswersListRequestWrapper(
        mdomTpIntQuestionAnswersListRequest);
    return mdomTpIntApi
        .questionAnswersListRequest(wrapper)
        .then((it) => it.psTpInt.response);
  }
}
