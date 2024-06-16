import 'package:dio/dio.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:retrofit/retrofit.dart';


part 'archives_api.g.dart';
@RestApi() 
abstract interface class ArchivesApi {
  factory ArchivesApi(Dio dio, {String baseUrl}) = _ArchivesApi;

  @GET('/archive_db')
  Future<HttpResponse<List<ArchiveDB>>> getArchives({
    @Header('Authorization') required String auth,
    @Query('order') String? order
  });
}


