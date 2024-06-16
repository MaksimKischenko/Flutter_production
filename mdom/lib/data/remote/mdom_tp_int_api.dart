import 'package:bpc/data/data.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'mdom_tp_int_api.g.dart';

@RestApi()
abstract class MdomTpIntApi {
  factory MdomTpIntApi(Dio dio, {String baseUrl}) = _MdomTpIntApi;

  @POST('/vote/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<MdomTpIntEntityPollsListResponseWrapper> pollsListRequest(
    @Body() MdomTpIntEntityPollsListRequestWrapper body,
  );

  @POST('/vote/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<MdomTpIntAddPollResponseWrapper> addPollRequest(
    @Body() MdomTpIntAddPollRequestWrapper body,
  );

  @POST('/vote/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<MdomTpIntEditPollResponseWrapper> editPollRequest(
    @Body() MdomTpIntEditPollRequestWrapper body,
  );

  @POST('/vote/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<MdomTpIntDeletePollResponseWrapper> deletePollRequest(
    @Body() MdomTpIntDeletePollRequestWrapper body,
  );

  @POST('/vote/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<MdomTpIntNotificationPollResponseWrapper> notificationPollRequest(
    @Body() MdomTpIntNotificationPollRequestWrapper body,
  );

  @POST('/vote/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<MdomTpIntCancelPollResponseWrapper> cancelPollRequest(
    @Body() MdomTpIntCancelPollRequestWrapper body,
  );

  @POST('/vote/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<MdomTpIntPollMembersListResponseWrapper> pollMembersListRequest(
    @Body() MdomTpIntPollMembersListRequestWrapper body,
  );

  @POST('/vote/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<MdomTpIntQuestionAnswersListResponseWrapper>
      questionAnswersListRequest(
    @Body() MdomTpIntQuestionAnswersListRequestWrapper body,
  );
}
