import 'package:dio/dio.dart' hide Headers;
import 'package:helppay_core/data/data.dart';
import 'package:retrofit/retrofit.dart';

part 'mdom_tp_int_api.g.dart';

@RestApi()
abstract class MdomTpIntApi {
  factory MdomTpIntApi(Dio dio, {String baseUrl}) = _MdomTpIntApi;

  @POST('/vote/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<MdomTpIntIndividualPollsListResponseWrapper> pollsListRequest(
      @Body() MdomTpIntIndividualPollsListRequestWrapper body);

  @POST('/vote/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<MdomTpIntQuestionAnswersListResponseWrapper>
      questionAnswersListRequest(
          @Body() MdomTpIntQuestionAnswersListRequestWrapper body);

  @POST('/vote/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<MdomTpIntVotePollResponseWrapper> votePollRequest(
      @Body() MdomTpIntVotePollRequestWrapper body);

  @POST('/vote/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<MdomTpIntNotifyListResponseWrapper> notifyListRequest(
      @Body() MdomTpIntNotifyListRequestWrapper body);

  @POST('/vote/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<MdomTpIntNotifyReadResponseWrapper> notifyReadRequest(
      @Body() MdomTpIntNotifyReadRequestWrapper body);
}
