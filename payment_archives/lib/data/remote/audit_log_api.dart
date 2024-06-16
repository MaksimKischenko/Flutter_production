import 'package:dio/dio.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:retrofit/retrofit.dart';


part 'audit_log_api.g.dart';
@RestApi() 
abstract interface class AuditLogApi {
  factory AuditLogApi(Dio dio, {String baseUrl}) = _AuditLogApi;

  @GET('/action_log')
  Future<HttpResponse<List<AuditLog>>> getAudits({
    @Header('Authorization') required String auth,
    @Query('limit') int? count,
    @Query('offset') int? offset,
    @Query('order') String? order,
    @Query('and') String? date,
    @Query('user_name') String? userName,
  });
}
