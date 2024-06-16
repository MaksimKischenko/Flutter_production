import 'package:dio/dio.dart' hide Headers;
import 'package:payment_tracking_module/data/data.dart';
import 'package:retrofit/retrofit.dart';

part 'users_api.g.dart';

@RestApi() 
abstract interface class UsersApi {
  factory UsersApi(Dio dio, {String baseUrl}) = _UsersApi;


  @GET('/user_')
  Future<HttpResponse<List<User>>> getUsers({
    @Header('Authorization') required String auth,
    @Query('limit') int? count,
    @Query('order') String? order,
    @Query('offset') int? offset,
    @Query('blocked') String? status,
    @Query('type_id') String? typeId,
    @Query('name') String? fio,
    @Query('user_id') String? id,
  });

  @POST('/user_')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<HttpResponse<List<User>>> saveUser({
    @Header('Authorization') required String auth,
    @Body() required UserInsertRequest body
  });

  @PATCH('/user_')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<HttpResponse<List<User>>> editUser({
    @Header('Authorization') required String auth,
    @Query('user_id') required String id,
    @Body() required UserUpdateRequest body
  });

 @DELETE('/user_')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<HttpResponse<List<User>>> deleteUser({
    @Header('Authorization') required String auth,
    @Query('user_id') required String id
  });
}







 