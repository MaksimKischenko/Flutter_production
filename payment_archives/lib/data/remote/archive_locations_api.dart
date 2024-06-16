import 'package:dio/dio.dart' hide Headers;
import 'package:payment_tracking_module/data/data.dart';
import 'package:retrofit/retrofit.dart';



part 'archive_locations_api.g.dart';

@RestApi() 
abstract interface class ArchiveLocationsApi {
  factory ArchiveLocationsApi(Dio dio, {String baseUrl}) = _ArchiveLocationsApi;


  @GET('/archive_location')
  Future<HttpResponse<List<ArchiveLocation>>> getArchiveLocations({
    @Header('Authorization') required String auth,
    @Query('id') String? id,
    @Query('order') String? order,    
  });

  @POST('/archive_location')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<HttpResponse<List<ArchiveLocation>>> saveArchiveLocation({
    @Header('Authorization') required String auth,
    @Body() required ArchiveLocationInsertRequest body
  });

  @PATCH('/archive_location')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<HttpResponse<List<ArchiveLocation>>> editArchiveLocation({
    @Header('Authorization') required String auth,
    @Query('id') required String id,
    @Body() required ArchiveLocationUpdateRequest body
  });

 @DELETE('/archive_location')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<HttpResponse<List<ArchiveLocation>>> deleteArchiveLocation({
    @Header('Authorization') required String auth,
    @Query('id') required String id
  });
}







 