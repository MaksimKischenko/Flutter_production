import 'package:dio/dio.dart' hide Headers;
import 'package:fl_qr_module/data/data.dart';
import 'package:retrofit/retrofit.dart';

part 'komplat_api.g.dart';

@RestApi()
abstract class KomplatApi {
  factory KomplatApi(Dio dio, {String baseUrl}) = _KomplatApi;

  @GET('')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<String> testRequest();

  @POST('')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<PsEripConfirmResponseWrapper> confirmRequest(
      @Body() PsEripConfirmRequestWrapper body);

  @POST('')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<PsEripGetPayListResponseWrapper> getPayListRequest(
      @Body() PsEripGetPayListRequestWrapper body);

  @POST('')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<PsEripRunOperationResponseWrapper> runOperationRequest(
      @Body() PsEripRunOperationRequestWrapper body);

}
