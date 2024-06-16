import 'package:dio/dio.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:retrofit/retrofit.dart';


part 'available_archive_locations_api.g.dart';
@RestApi() 
abstract interface class AvailableArchiveLocationsApi {
  factory AvailableArchiveLocationsApi(Dio dio, {String baseUrl}) = _AvailableArchiveLocationsApi;

  @GET('/source_available_location')
  Future<HttpResponse<List<AvailableArchiveLocation>>> getAvailableArchiveLocations({
    @Header('Authorization') required String auth,
    @Query('source_id') String? id,
    @Query('order') String? order
  });
}


