import 'package:dio/dio.dart';
import 'package:isc_web_app/data/data.dart';
import 'package:retrofit/retrofit.dart';

part 'komplat_isc_api.g.dart';

@RestApi()
abstract class KomplatISCApi {
  factory KomplatISCApi(Dio dio, {String baseUrl}) = _KomplatISCApi;

  @POST('/rpc/tpayero_user_execute') 
  Future<MdomLoginResponseWrapper> loginRequest(
    @Body() MdomLoginRequestWrapper body
  );

  @POST('/rpc/tpayero_execute')
  Future<PsTpOClaimsListResponseWrapper> claimsListRequest(@Body() PsTpOClaimsListRequestWrapper body);

  @POST('/rpc/tpayero_execute')
  Future<PsTpORegisterPaymentClaimResponseWrapper> registerPaymentClaimRequest(@Body() PsTpORegisterPaymentClaimRequestWrapper body);

  @POST('/kp_isc/online.request')
  Future<PsTpOAddClaimResponseWrapper> addClaimRequest(@Body() PsTpOAddClaimRequestWrapper body);

  @POST('/rpc/tpayero_execute')
  Future<PsTpOPaymentsListResponseWrapper> paymentsListRequest(@Body() PsTpOPaymentsListRequestWrapper body);
}