import 'package:dio/dio.dart' hide Headers;
import 'package:payment_tracking_module/data/data.dart';
import 'package:retrofit/retrofit.dart';

part 'data_sources_api.g.dart';

@RestApi() 
abstract interface class DataSourcesApi {
  factory DataSourcesApi(Dio dio, {String baseUrl}) = _DataSourcesApi;


  @GET('/data_source')
  Future<HttpResponse<List<DataSource>>> getDataSources({
    @Header('Authorization') required String auth,
    @Query('id') String? id,
    @Query('order') String? order
  });

  @POST('/data_source')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<HttpResponse<List<DataSource>>> saveDataSources({
    @Header('Authorization') required String auth,
    @Body() required DataSourceInsertRequest body
  });

  @PATCH('/data_source')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<HttpResponse<List<DataSource>>> editDataSources({
    @Header('Authorization') required String auth,
    @Query('id') required String id,
    @Body() required DataSourceUpdateRequest body
  });

 @DELETE('/data_source')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<HttpResponse<List<DataSource>>> deleteDataSources({
    @Header('Authorization') required String auth,
    @Query('id') required String id
  });
}







 