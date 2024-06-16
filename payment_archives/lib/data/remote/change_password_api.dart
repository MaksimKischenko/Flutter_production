import 'package:dio/dio.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:retrofit/retrofit.dart';


part 'change_password_api.g.dart';
@RestApi() 
abstract interface class ChangePasswordApi {
  factory ChangePasswordApi(Dio dio, {String baseUrl}) = _ChangePasswordApi;

  @POST('/rpc/user_change_password')
  Future<HttpResponse<ChangePasswordResponse>> getNewPassword({
    @Header('Authorization') required String auth,
    @Body() required ChangePasswordRequest body,
  });
}