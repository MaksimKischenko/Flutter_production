import 'package:bpc/data/data.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'mdom_api.g.dart';

@RestApi()
abstract class MdomApi {
  factory MdomApi(Dio dio, {String baseUrl}) = _MdomApi;

  @POST('/user/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<MdomCreateResponseWrapper> createRequest(
    @Body() MdomCreateRequestWrapper body,
  );

  @POST('/user/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<MdomEditUserResponseWrapper> editUserRequest(
    @Body() MdomEditUserRequestWrapper body,
  );

  @POST('/user/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<MdomLoginResponseWrapper> loginRequest(
    @Body() MdomLoginRequestWrapper body,
  );
}
