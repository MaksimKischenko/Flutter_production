import 'package:dio/dio.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:retrofit/retrofit.dart';


part 'map_allocations_api.g.dart';
@RestApi() 
abstract interface class MapAllocationsApi {
  factory MapAllocationsApi(Dio dio, {String baseUrl}) = _MapAllocationsApi;

  @GET('/map_allocation_archive')
  Future<HttpResponse<List<MapAllocationData>>> getMapAllocations({
    @Header('Authorization') required String auth,
    @Query('archive_db_id') String? id,
    @Query('order') String? order
  });
}


