import 'package:dio/dio.dart' hide Headers;
import 'package:helppay_core/data/data.dart';
import 'package:retrofit/retrofit.dart';

part 'mdom_api.g.dart';

@RestApi()
abstract class MdomApi {
  factory MdomApi(Dio dio, {String baseUrl}) = _MdomApi;

  @GET('/user/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<String> testRequest();

  @POST('/user/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<MdomCreateResponseWrapper> createRequest(
      @Body() MdomCreateRequestWrapper body);

  @POST('/user/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<MdomEditUserResponseWrapper> editUserRequest(
      @Body() MdomEditUserRequestWrapper body);

  @POST('/user/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<MdomDeleteUserResponseWrapper> deleteUserRequest(
      @Body() MdomDeleteUserRequestWrapper body);

  @POST('/user/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<MdomLoginResponseWrapper> loginRequest(
      @Body() MdomLoginRequestWrapper body);

  @POST('/user/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<MdomResetPasswordResponseWrapper> resetPasswordRequest(
      @Body() MdomResetPasswordRequestWrapper body);

  @POST('/user/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<MdomRefreshTokenResponseWrapper> refreshTokenRequest(
      @Body() MdomRefreshTokenRequestWrapper body);
}
