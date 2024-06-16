import 'package:dio/dio.dart' hide Headers;
import 'package:payment_tracking_module/data/data.dart';
import 'package:retrofit/retrofit.dart';

part 'payments_api.g.dart';
@RestApi() 
abstract interface class PaymentsApi {
  factory PaymentsApi(Dio dio, {String baseUrl}) = _PaymentsApi;

  @POST('/rpc/search_payment')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<HttpResponse<String>> searchPaymentFullInit({
    @Header('Authorization') required String auth,
    @Body() required SearchPaymentData body
  });

  @POST('/rpc/search_payment_external_id')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<HttpResponse<String>> searchPaymentIdsInit({
    @Header('Authorization') required String auth,
    @Body() required SearchPaymentData body
  });

  @POST('/rpc/search_payment_full_name')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<HttpResponse<String>> searchPaymentNamesInit({
    @Header('Authorization') required String auth,
    @Body() required SearchPaymentData body
  });

  @POST('/rpc/get_search_result')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<HttpResponse<List<Payment>>> searchPaymentResult({
    @Header('Authorization') required String auth,
    @Body() required FinalSearchPaymentRequest body
  });
}


