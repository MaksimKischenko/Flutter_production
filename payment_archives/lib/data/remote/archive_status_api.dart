import 'package:dio/dio.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:retrofit/retrofit.dart';

part 'archive_status_api.g.dart';
@RestApi() 
abstract interface class ArchiveStatusApi {
  factory ArchiveStatusApi(Dio dio, {String baseUrl}) = _ArchiveStatusApi;

  @GET('/archive_status')
  Future<HttpResponse<List<ArchiveStatus>>> getArchiveStatus({
    @Header('Authorization') required String auth,
    @Query('order') String? order,
  });
}


