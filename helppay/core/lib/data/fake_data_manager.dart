import 'package:dio/dio.dart';
import 'package:helppay_core/data/remote_models/common_models/common_models.dart';
import 'package:helppay_core/models/models.dart';
import 'package:retrofit/retrofit.dart';

import 'data.dart';

class FakeDataManager extends DataManager {
  FakeDataManager(Dio dio) : super(dio);

  final _delay = Future<void>.delayed(const Duration(seconds: 2));

  @override
  Future<ConfirmResponse> confirmRequest({
    required int diType,
    required PayRecordResponse service,
    bool isCanceled = false,
  }) async {
    await _delay;
    return const ConfirmResponse(
      errorCode: 1,
      errorText: 'unimplemented',
    );
  }

  @override
  Future<GetPayListResponse> getPayListRequest({
    required int diType,
    FilterQr? filter,
    int? payCode,
    String? sessionId,
    List<AttrRecordRequest>? attrRecord,
  }) async {
    await _delay;
    return const GetPayListResponse(
      errorCode: 1,
      errorText: 'unimplemented',
    );
  }

  @override
  Future<RunOperationResponse> runOperationRequest({
    required PayRecordResponse service,
    required Pan? pan,
    required TypePan? typePan,
    required List<AttrRecordRequest> attrs,
    required int? kioskReceipt,
    required int? diType,
    required String payDate,
  }) async {
    await _delay;
    return const RunOperationResponse(
      errorCode: 1,
      errorText: 'unimplemented',
    );
  }

  @override
  Future<MdomCreateResponse> createRequest({
    required String login,
    required String fio,
    required String password,
    String? phone,
    bool isSendCodeSMS = false,
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
  Future<MdomLoginResponse> loginRequest({
    String? login,
    String? password,
    int? code,
  }) async {
    await _delay;
    return MdomLoginResponse(
      requestType: 'LoginResponse',
      token: const MdomToken(
        evalue: 'fakeToken',
        terminalId: 'fakeTerminal',
        version: '1',
      ),
      helppayKey: '',
      errorCode: const MdomErrorCode(
        evalue: 0,
      ),
      products: MdomLoginResponseProducts(
        ruleNew: [
          MdomLoginResponseProductsCurrent(
            params: MdomResponseParams(
              params: [
                MdomResponseParam(
                  evalue: AliasList.typePanAccount,
                  name: 'account type',
                  type: 0,
                  id: 1,
                  alias: AliasList.typePan,
                ),
                MdomResponseParam(
                  name: 'account number',
                  type: 0,
                  id: 2,
                  alias: AliasList.number,
                ),
                MdomResponseParam(
                  name: 'account name',
                  type: 0,
                  id: 3,
                  alias: AliasList.productName,
                ),
                MdomResponseParam(
                  name: 'account activity',
                  type: 0,
                  id: 4,
                  alias: AliasList.defaultFlag,
                ),
              ],
            ),
          ),
          MdomLoginResponseProductsCurrent(
            params: MdomResponseParams(
              params: [
                MdomResponseParam(
                  evalue: AliasList.typePanCard,
                  name: 'card type',
                  type: 0,
                  id: 1,
                  alias: AliasList.typePan,
                ),
                MdomResponseParam(
                  name: 'card number',
                  type: 0,
                  id: 201,
                  alias: AliasList.number,
                ),
                MdomResponseParam(
                  name: 'card expiration date',
                  type: 3,
                  id: 202,
                  alias: AliasList.expirationDate,
                ),
                MdomResponseParam(
                  name: 'card cvv',
                  type: 3,
                  id: 203,
                  alias: AliasList.cvv,
                ),
                MdomResponseParam(
                  name: 'card name',
                  type: 0,
                  id: 204,
                  alias: AliasList.productName,
                ),
                MdomResponseParam(
                  name: 'card activity',
                  type: 0,
                  id: 205,
                  alias: AliasList.defaultFlag,
                ),
              ],
            ),
          ),
        ],
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
  Future<MdomDeleteUserResponse> deleteUserRequest({
    String? login,
    int? userId,
  }) async {
    // final editUserRequest = MdomDeleteUserRequest(
    //   login: login,
    //   userId: userId,
    // );
    // final wrapper = MdomDeleteUserRequestWrapper(editUserRequest);
    // return mdomApi.deleteUserRequest(wrapper).then((it) => it.userResponse);

    await _delay;
    return const MdomDeleteUserResponse(
      requestType: 'DeleteUser',
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
  Future<MdomResetPasswordResponse> resetPasswordRequest(
      {String? login, String? email, String? phone}) async {
    await _delay;
    return MdomResetPasswordResponse(
      requestType: 'ResetPassword',
      token: 'fake_token',
      errorCode: MdomResetPasswordErrorCode(
        evalue: 1,
        errorText: 'unimplemented',
      ),
    );
  }

  @override
  Future<GetOperationHistoryResponse> getOperationHistoryRequest({
    required GetOperationHistoryRequestSourceId sourceId,
    required String dateFrom,
    required String dateTo,
    int count = 20,
    int? lastPaymentId,
  }) async {
    await _delay;
    return GetOperationHistoryResponse(
      errorCode: 1,
      errorText: 'unimplemented',
    );
  }

  @override
  Future<MdomCompaniesResponse> companiesRequest() async {
    await _delay;
    return MdomCompaniesResponse(
      requestType: 'CompaniesResponse',
      token: 'fakeToken',
      errorCode: const MdomTpInfoErrorCode(evalue: 0),
      companies: [
        CompaniesResponseCompany(
          supplierId: 1234,
          params: MdomTpInfoResponseParams(params: [
            MdomTpInfoResponseParam(
                alias: 'SUPPLIERNAME', evalue: 'The best supllier')
          ]),
          propertyAccount: [
            PropertyAccount(
                account:
                    PropertyAccountAccount(isConfirmed: 1, evalue: '1234')),
            PropertyAccount(
                account:
                    PropertyAccountAccount(isConfirmed: 0, evalue: '2345')),
          ],
        ),
      ],
    );
  }

  @override
  Future<MdomInfoSupplierResponse> infoSupplierRequest(
      {required int? supplierUNN, required String? supplierName}) async {
    await _delay;
    return const MdomInfoSupplierResponse(
      requestType: 'InfoSupplierResponse',
      token: 'fakeToken',
      errorCode: MdomTpInfoErrorCode(evalue: 1, errorText: 'unimplemented'),
    );
  }

  @override
  Future<MdomAccountRegistrationResponse> accountRegistrationRequest(
      {required String account,
      required int supplierId,
      required String? codeWord}) async {
    await _delay;
    return const MdomAccountRegistrationResponse(
      requestType: 'AccountRegistrationResponse',
      token: 'fakeToken',
      errorCode: MdomTpInfoErrorCode(evalue: 1, errorText: 'unimplemented'),
    );
  }

  @override
  Future<MdomAccountStatementResponse> accountStatementRequest({
    required DateTime from,
    required DateTime to,
    required int supplierId,
    required String account,
  }) async {
    await _delay;
    return const MdomAccountStatementResponse(
      requestType: 'AccountStatementResponse',
      token: 'fakeToken',
      errorCode: MdomTpInfoErrorCode(evalue: 1, errorText: 'unimplemented'),
      periods: [],
    );
  }

  @override
  Future<IndividualPollsListResponse> pollsListRequest({
    String? topic,
    required PollStatus status,
    required DateTime stopDateFrom,
    required DateTime stopDateTo,
    int? supplierId,
    int? count,
    int? lastPollId,
  }) async {
    await _delay;
    return IndividualPollsListResponse(
      version: 1,
      keyRequest: 1234,
      errorCode: 0,
      participantsCount: 3,
      polls: lastPollId == null
          ? [
              const Poll(
                id: 1,
                topic:
                    'Собрание №2 по вопросу №123 по вопросу покраски детской площадки Собрание №2 по вопросу №123 по вопросу покраски детской площадки',
                status: PollStatus.inProgress,
                startDate: '01.01.2022',
                stopDate: '02.01.2022',
                url: 'http://192.168.249.58/',
                anonymous: 1,
                account: '123123123',
                voted: 0,
                votedCount: 2,
                answerEditDisabled: 1,
                questions: [
                  PollListQuestion(
                    value: 'Установить членский взнос в размере 20 р.?',
                    idx: 1,
                    positiveCount: 10,
                    negativeCount: 20,
                    abstainedCount: 30,
                    currentVote: null,
                  ),
                  PollListQuestion(
                    value: 'Покрасить детскую площадку?',
                    idx: 2,
                    description: 'description',
                    currentVote: null,
                  ),
                  PollListQuestion(
                    value: 'Установить членский взнос в размере 30 р.?',
                    idx: 3,
                    description: 'description',
                    currentVote: null,
                  ),
                  PollListQuestion(
                    value: 'Покрасить Дом 1?',
                    idx: 4,
                    description: 'description',
                    currentVote: null,
                  ),
                  PollListQuestion(
                      value: 'Покрасить Дом 2?',
                      idx: 5,
                      description: 'description',
                      currentVote: null),
                ],
              ),
              const Poll(
                id: 1,
                topic:
                    'Собрание №2 по вопросу №123 по вопросу покраски детской площадки Собрание №2 по вопросу №123 по вопросу покраски детской площадки',
                status: PollStatus.inProgress,
                startDate: '01.01.2022',
                stopDate: '02.01.2022',
                url: 'http://192.168.249.58/',
                anonymous: 1,
                account: '567567567',
                voted: 1,
                votedCount: 2,
                answerEditDisabled: 1,
                questions: [
                  PollListQuestion(
                    value: 'Установить членский взнос в размере 20 р.?',
                    idx: 1,
                    positiveCount: 10,
                    negativeCount: 20,
                    abstainedCount: 30,
                    currentVote: PollAnswer.abstain,
                  ),
                  PollListQuestion(
                    value: 'Покрасить детскую площадку?',
                    idx: 2,
                    description: 'description',
                    currentVote: PollAnswer.yes,
                  ),
                  PollListQuestion(
                    value: 'Установить членский взнос в размере 30 р.?',
                    idx: 3,
                    description: 'description',
                    currentVote: PollAnswer.no,
                  ),
                  PollListQuestion(
                    value: 'Покрасить Дом 1?',
                    idx: 4,
                    description: 'description',
                    currentVote: PollAnswer.yes,
                  ),
                  PollListQuestion(
                    value: 'Покрасить Дом 2?',
                    idx: 5,
                    description: 'description',
                    currentVote: PollAnswer.yes,
                  ),
                ],
              ),
              const Poll(
                id: 2,
                topic: 'poll 2',
                status: PollStatus.completed,
                startDate: '02.01.2022',
                stopDate: '03.01.2022',
                url: 'http://192.168.249.58/',
                anonymous: 0,
                account: '123123123',
                voted: 0,
                votedCount: 2,
                answerEditDisabled: 1,
                questions: [
                  PollListQuestion(
                    value: 'first question',
                    idx: 1,
                    positiveCount: 10,
                    negativeCount: 20,
                    abstainedCount: 30,
                    currentVote: null,
                  ),
                  PollListQuestion(
                    value: 'second question',
                    idx: 2,
                    description: 'description',
                    currentVote: null,
                  ),
                  PollListQuestion(
                    value: 'third question',
                    idx: 3,
                    description: 'description',
                    currentVote: null,
                  ),
                ],
              ),
              const Poll(
                id: 2,
                topic: 'poll 2',
                status: PollStatus.completed,
                startDate: '02.01.2022',
                stopDate: '03.01.2022',
                url: 'http://192.168.249.58/',
                anonymous: 0,
                account: '567567567',
                voted: 1,
                votedCount: 2,
                answerEditDisabled: 1,
                questions: [
                  PollListQuestion(
                    value: 'first question',
                    idx: 1,
                    positiveCount: 10,
                    negativeCount: 20,
                    abstainedCount: 30,
                    currentVote: PollAnswer.abstain,
                  ),
                  PollListQuestion(
                    value: 'second question',
                    idx: 2,
                    description: 'description',
                    currentVote: PollAnswer.yes,
                  ),
                  PollListQuestion(
                    value: 'third question',
                    idx: 3,
                    description: 'description',
                    currentVote: PollAnswer.no,
                  ),
                ],
              ),
              const Poll(
                id: 3,
                topic:
                    'Собрание №4 по вопросу №123 по вопросу покраски детской площадки Собрание №2 по вопросу №123 по вопросу покраски детской площадки',
                status: PollStatus.publication,
                startDate: '01.01.2022',
                stopDate: '02.01.2022',
                url: 'http://192.168.249.58/',
                anonymous: 1,
                account: '123123123',
                votedCount: 0,
                answerEditDisabled: 1,
                questions: [
                  PollListQuestion(
                    value: 'Установить членский взнос в размере 20 р.?',
                    idx: 1,
                  ),
                  PollListQuestion(
                    value: 'Покрасить детскую площадку?',
                    idx: 2,
                    description: 'description',
                  ),
                  PollListQuestion(
                    value: 'Установить членский взнос в размере 30 р.?',
                    idx: 3,
                    description: 'description',
                  ),
                  PollListQuestion(
                    value: 'Покрасить Дом 1?',
                    idx: 4,
                    description: 'description',
                  ),
                  PollListQuestion(
                    value: 'Покрасить Дом 2?',
                    idx: 5,
                    description: 'description',
                  ),
                ],
              ),
              const Poll(
                id: 3,
                topic:
                    'Собрание №4 по вопросу №123 по вопросу покраски детской площадки Собрание №2 по вопросу №123 по вопросу покраски детской площадки',
                status: PollStatus.publication,
                startDate: '01.01.2022',
                stopDate: '02.01.2022',
                url: 'http://192.168.249.58/',
                anonymous: 1,
                account: '567567567',
                votedCount: 0,
                answerEditDisabled: 1,
                questions: [
                  PollListQuestion(
                    value: 'Установить членский взнос в размере 20 р.?',
                    idx: 1,
                  ),
                  PollListQuestion(
                    value: 'Покрасить детскую площадку?',
                    idx: 2,
                    description: 'description',
                  ),
                  PollListQuestion(
                    value: 'Установить членский взнос в размере 30 р.?',
                    idx: 3,
                    description: 'description',
                  ),
                  PollListQuestion(
                    value: 'Покрасить Дом 1?',
                    idx: 4,
                    description: 'description',
                  ),
                  PollListQuestion(
                    value: 'Покрасить Дом 2?',
                    idx: 5,
                    description: 'description',
                  ),
                ],
              ),
              const Poll(
                id: 7,
                topic:
                    'Собрание №7 по вопросу №123 по вопросу покраски детской площадки Собрание №2 по вопросу №123 по вопросу покраски детской площадки',
                status: PollStatus.completed,
                startDate: '01.01.2022',
                stopDate: '02.01.2022',
                url: 'http://192.168.249.58/',
                anonymous: 0,
                account: '123123123',
                votedCount: 2,
                answerEditDisabled: 1,
                questions: [
                  PollListQuestion(
                    value: 'Установить членский взнос в размере 20 р.?',
                    idx: 1,
                  ),
                  PollListQuestion(
                    value: 'Покрасить детскую площадку?',
                    idx: 2,
                    description: 'description',
                  ),
                  PollListQuestion(
                    value: 'Установить членский взнос в размере 30 р.?',
                    idx: 3,
                    description: 'description',
                  ),
                  PollListQuestion(
                    value: 'Покрасить Дом 1?',
                    idx: 4,
                    description: 'description',
                  ),
                  PollListQuestion(
                    value: 'Покрасить Дом 2?',
                    idx: 5,
                    description: 'description',
                  ),
                ],
              ),
              const Poll(
                id: 7,
                topic:
                    'Собрание №7 по вопросу №123 по вопросу покраски детской площадки Собрание №2 по вопросу №123 по вопросу покраски детской площадки',
                status: PollStatus.completed,
                startDate: '01.01.2022',
                stopDate: '02.01.2022',
                url: 'http://192.168.249.58/',
                anonymous: 0,
                account: '567567567',
                voted: 1,
                votedCount: 2,
                answerEditDisabled: 1,
                questions: [
                  PollListQuestion(
                    value: 'Установить членский взнос в размере 20 р.?',
                    idx: 1,
                    currentVote: PollAnswer.abstain,
                  ),
                  PollListQuestion(
                    value: 'Покрасить детскую площадку?',
                    idx: 2,
                    description: 'description',
                    currentVote: PollAnswer.abstain,
                  ),
                  PollListQuestion(
                    value: 'Установить членский взнос в размере 30 р.?',
                    idx: 3,
                    description: 'description',
                    currentVote: PollAnswer.abstain,
                  ),
                  PollListQuestion(
                    value: 'Покрасить Дом 1?',
                    idx: 4,
                    description: 'description',
                    currentVote: PollAnswer.abstain,
                  ),
                  PollListQuestion(
                    value: 'Покрасить Дом 2?',
                    idx: 5,
                    description: 'description',
                    currentVote: PollAnswer.abstain,
                  ),
                ],
              ),
            ]
          : null,
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

  @override
  Future<VotePollResponse> votePollRequest({
    required int pollId,
    required String account,
    required List<VotePollQuestion> questions,
  }) async {
    await _delay;

    return const VotePollResponse(
      version: 1,
      keyRequest: 1234,
      errorCode: 0,
    );
  }

  @override
  Future<MdomRefreshTokenResponse> refreshTokenRequest(String token) async =>
      // final refreshRequest = MdomRefreshTokenRequest(
      //     terminalId: terminalId,
      //     version: mdomTpInfoVersion,
      //     token: token,
      //     lang: await lang);
      // final wrapper = MdomRefreshTokenRequestWrapper(refreshRequest);
      const MdomRefreshTokenResponse(token: MdomToken(evalue: '123412421'));

  @override
  Future<NotificationListResponse> notifyListRequest({
    required int supplierId,
    required NotifyListRequestRowCount rowCount,
  }) async {
    await _delay;
    final time = DateTime.now();
    return NotificationListResponse(
        version: 1,
        keyRequest: 1234,
        errorCode: 0,
        unreadCount: 1,
        notification: [
          ResponseNotification(
            id: 1,
            message: 'Test message',
            status: 0,
            topic: 'rer',
            stopDate: time.toString(),
          ),
          ResponseNotification(
            id: 3,
            message: 'Test message 2',
            status: 0,
            topic: 'rer',
            stopDate: time.toString(),
          ),
          ResponseNotification(
            id: 2,
            message: 'Test message 3',
            status: 0,
            topic: 'rer',
            stopDate: time.toString(),
          ),
        ]);
  }

  @override
  Future<NotificationReadResponse> notifyReadRequest(
      {required int lastNotificationIndicator}) async {
    await _delay;

    return NotificationReadResponse(
      version: 1,
      keyRequest: 1234,
      errorCode: 0,
    );
  }

  @override
  Future<GetPrimarySecretKeyResponse> getPrimarySecretKeyRequest(
      {required String terminalId}) async {
    await _delay;
    return GetPrimarySecretKeyResponse(secretKey: '11111111', errorCode: 0);
  }

  @override
  Future<HttpResponse<String>> getSecretKeyRequest({
    required String requestTime,
    required RegPayMinTerminalID terminalID,
    required String? typePan,
    required QrPan? pan,
  }) async {
    await _delay;
    return HttpResponse(
        '', Response<dynamic>(requestOptions: RequestOptions(path: '')));
  }

  @override
  Future<HttpResponse<String>> getQrRequest({
    required String requestTime,
    required RegPayMinTerminalID terminalID,
    required String typePan,
    required QrPan pan,
    required double restSum,
    double? paymentSum,
  }) async {
    await _delay;

    return HttpResponse(
        '', Response<dynamic>(requestOptions: RequestOptions(path: '')));
  }

  @override
  Future<HttpResponse<String>> confirmQrPaymentRequest({
    required String requestTime,
    required RegPayMinTerminalID terminalID,
    required String typePan,
    required QrPan pan,
    required int requestId,
    required int? otpCode,
    required int confirmCode,
  }) async {
    await _delay;
    return HttpResponse(
        '', Response<dynamic>(requestOptions: RequestOptions(path: '')));
  }

  @override
  Future<HttpResponse<String>> getQROperationRequest({
    required String requestTime,
    required RegPayMinTerminalID terminalID,
    required String typePan,
    required QrPan pan,
    required int requestId,
    required OperationFilter filter,
  }) async {
    await _delay;

    return HttpResponse(
        '', Response<dynamic>(requestOptions: RequestOptions(path: '')));
  }

  @override
  Future<HttpResponse<String>> getQRCheckDuplicateRequest({
    required String requestTime,
    required RegPayMinTerminalID terminalID,
    required String typePan,
    required QrPan pan,
    required int requestId,
    required int? advancedInfoRequired,
  }) async {
    await _delay;

    return HttpResponse(
        '', Response<dynamic>(requestOptions: RequestOptions(path: '')));
  }

  @override
  Future<HttpResponse<String>> getRequestStatusRequest({
    required String requestTime,
    required RegPayMinTerminalID terminalID,
    required int version,
    required String typePan,
    required QrPan pan,
    required int requestId,
  }) async {
    await _delay;

    return HttpResponse(
        '', Response<dynamic>(requestOptions: RequestOptions(path: '')));
  }

  @override
  Future<HttpResponse<String>> registerPaymentRequest({
    required String requestTime,
    required RegPayMinTerminalID terminalID,
    required int version,
    required String typePan,
    required QrPan pan,
    required int requestId,
  }) async {
    await _delay;

    return HttpResponse(
        '', Response<dynamic>(requestOptions: RequestOptions(path: '')));
  }

  @override
  Future<HttpResponse<String>> registerPaymentMethodRequest(
      {required String requestTime,
      required RegPayMinTerminalID terminalID,
      required int version,
      required String typePan,
      QrPan? pan,
      CardEmissionParam? cardEmissionParam}) async {
    await _delay;

    return HttpResponse(
        '', Response<dynamic>(requestOptions: RequestOptions(path: '')));
  }

  @override
  Future<HttpResponse<String>> confirmPaymentMethodRequest({
    required String requestTime,
    required RegPayMinTerminalID terminalID,
    required int version,
    required String typePan,
    required RequestIdentifier requestId,
    QrPan? pan,
  }) async {
    await _delay;

    return HttpResponse(
        '', Response<dynamic>(requestOptions: RequestOptions(path: '')));
  }

  @override
  Future<GetBalanceResponse> getBalanceRequest({
    required Pan? pan,
    required int diType,
    required TypePan? typePan,
  }) async {
    final getBalanceRequest = GetBalanceRequest(
      terminalID: terminalId,
      version: versionKomplat,
      diType: diType, //TODO change to proper data
      token: token,
      pan: pan,
      typePan: typePan,
      currency: 933, //hardcoded be carefull
      requestType: 0, //0- for balance request, 1- for balance refill request
    );

    final psEripGetBalanceRequest = PsEripGetBalanceRequest(getBalanceRequest);
    final wrapper = PsEripGetBalanceRequestWrapper(psEripGetBalanceRequest);
    return komplatApi
        .getBalanceReguest(wrapper)
        .then((it) => it.psErip.response);
  }
}
