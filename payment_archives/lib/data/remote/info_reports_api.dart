import 'package:dio/dio.dart' hide Headers;
import 'package:payment_tracking_module/data/data.dart';
import 'package:retrofit/retrofit.dart';


part 'info_reports_api.g.dart';
@RestApi() 
abstract interface class InfoReportsApi{
  factory InfoReportsApi(Dio dio, {String baseUrl}) = _InfoReportsApi;

  @POST('/rpc/get_payment_attr')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<HttpResponse<String>> paymentAttrRequest({
    @Header('Authorization') required String auth,
    @Body() required PaymentAtrrRequest body
  });

  @POST('/rpc/curr2word')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<HttpResponse<String>> curr2word({
    @Header('Authorization') required String auth,
    @Body() required CurrencyRequest body
  });
}
