import 'package:dio/dio.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:retrofit/retrofit.dart';


part 'user_type_api.g.dart';
@RestApi() 
abstract interface class UserTypeApi {
  factory UserTypeApi(Dio dio, {String baseUrl}) = _UserTypeApi;

  @GET('/user_type')
  Future<HttpResponse<List<UserType>>> getUserType({
    @Header('Authorization') required String auth,
  });
}


