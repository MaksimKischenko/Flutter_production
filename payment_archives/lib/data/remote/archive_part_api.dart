import 'package:dio/dio.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:retrofit/retrofit.dart';


part 'archive_part_api.g.dart';
@RestApi() 
abstract interface class ArchivePartsApi {
  factory ArchivePartsApi(Dio dio, {String baseUrl}) = _ArchivePartsApi;

  @GET('/archive_db_part')
  Future<HttpResponse<List<ArchiveDBPart>>> getArchiveParts({
    @Header('Authorization') required String auth,
    @Query('archive_id') String? id,
    @Query('order') String? order, 
  });
}


