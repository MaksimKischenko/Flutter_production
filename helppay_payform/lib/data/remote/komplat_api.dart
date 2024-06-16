import 'package:dio/dio.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:retrofit/retrofit.dart';

part 'komplat_api.g.dart';

@RestApi()
abstract class KomplatApi {
  factory KomplatApi(Dio dio, {String baseUrl}) = _KomplatApi;

  @GET('/payments/{token}')
  Future<PaymentsResponse> paymentsRequest(
    @Path('token') String token,
  );

  @DELETE('/payments/{token}/{id}')
  Future<DeletePaymentResponse> deletePaymentRequest({
    @Path('token') required String token,
    @Path('id') required int id,
  });

  @GET('/popular/{token}')
  Future<ListPopularResponse> listPopularRequest({
    @Path('token') required String token,
    @Query('count') required int count
  });

  @POST('/session')
  Future<InitHelpPayResponseWrapper> initHelppayRequest(@Body() InitHelpPayRequestWrapper body);  

  @POST('/session/delete')
  Future<DeleteHelpPayResponseWrapper> deleteHelppaySessionRequest(@Body() DeleteHelpPayRequestWrapper body);  

  @GET('/getPayList/filters/{token}')
  Future<GetPayListFiltersResponse> getPayListFiltersRequest({
    @Path('token') required String token
  });

  @POST('/getPayList/{token}')
  Future<GetPayListResponse> getPayListRequest({
    @Path('token') required String token,
    @Body() required GetPayListRequest body
  });

  @POST('/runOperation/{token}')
  Future<RunOperationResponse> runOperationRequest({
    @Path('token') required String token,
    @Body() required RunOperationRequest body
  });

  @GET('/checkDuplicate/{token}')
  Future<GetCheckDuplicateResponse> getCheckDuplicateRequest({
    @Path('token') required String token,
    @Query('paymentId') required int paymentId
  });

  @GET('/confirm/{token}')
  Future<ConfirmDebetResponse> confirmDebetRequest({
    @Path('token') required String token
  });
}