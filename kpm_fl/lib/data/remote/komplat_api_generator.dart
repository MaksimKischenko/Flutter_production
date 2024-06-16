import 'package:dio/dio.dart';
import 'package:kpm_fl/data/data.dart';
import 'package:retrofit/retrofit.dart';

part 'komplat_api_generator.g.dart';

/// данные файл используетя для генерации реализации интерфейса и копирования в KomplatApi
@RestApi()
abstract class KomplatApiGenerator {
  factory KomplatApiGenerator(Dio dio, {String baseUrl}) = _KomplatApiGenerator;

  @POST('/online.request')
  Future<PsEripListPopularResponseWrapper> listPopularRequest(
    @Body() PsEripListPopularRequestWrapper body,
  );

  @POST('/online.request')
  Future<PsEripGetPayListResponseWrapper> getPayListRequest(
    @Body() PsEripGetPayListRequestWrapper body
  );

  @POST('/online.request')
  Future<PsEripRunOperationResponseWrapper> runOperationRequest(
    @Body() PsEripRunOperationRequestWrapper body
  );

  @POST('/online.request')
  Future<PsEripUserProfileResponseWrapper> getUserProfileRequest(
    @Body() PsEripGetUserProfileRequestWrapper body
  );

  @POST('/online.request')
  Future<PsEripOpenBasketResponseWrapper> openBasketRequest(
    @Body() PsEripOpenBasketRequestWrapper body
  );

  @POST('/online.request')
  Future<PsEripCloseBasketResponseWrapper> closeBasketRequest(
    @Body() PsEripCloseBasketRequestWrapper body
  );

  @POST('/online.request')
  Future<PsEripConfirmResponseWrapper> confirmRequest(
    @Body() PsEripConfirmRequestWrapper body
  );

  @POST('/online.request')
  Future<PsEripSearchBasketResponseWrapper> searchBasketRequest(
    @Body() PsEripSearchBasketRequestWrapper body
  );

}