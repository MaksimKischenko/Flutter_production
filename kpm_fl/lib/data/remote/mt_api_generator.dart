import 'package:dio/dio.dart';
import 'package:kpm_fl/data/data.dart';
import 'package:retrofit/retrofit.dart';

part 'mt_api_generator.g.dart';

/// данные файл используетя для генерации реализации интерфейса и копирования в MtApi
@RestApi()
abstract class MtApiGenerator {
  factory MtApiGenerator(Dio dio, {String baseUrl}) = _MtApiGenerator;

  @POST('/online.request')
  Future<PsMtCheckConnectResponseWrapper> checkConnectionRequest(
    @Body() PsMtCheckConnectRequestWrapper body
  );

}