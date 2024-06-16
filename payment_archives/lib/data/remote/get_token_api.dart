import 'package:dio/dio.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:retrofit/retrofit.dart';


part 'get_token_api.g.dart';
@RestApi() 
abstract interface class GetTokendApi {
  factory GetTokendApi(Dio dio, {String baseUrl}) = _GetTokendApi;

  @POST('/rpc/token')
  Future<HttpResponse<TokenBody>> getToken({
    @Body() required LoginUserRequest body,
  });
}
