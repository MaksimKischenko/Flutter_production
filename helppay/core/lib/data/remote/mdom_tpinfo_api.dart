import 'package:dio/dio.dart' hide Headers;
import 'package:helppay_core/data/data.dart';
import 'package:retrofit/retrofit.dart';

part 'mdom_tpinfo_api.g.dart';

@RestApi()
abstract class MdomTpInfoApi {
  factory MdomTpInfoApi(Dio dio, {String baseUrl}) = _MdomTpInfoApi;

  @GET('/info/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<String> testRequest();

  @POST('/info/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<MdomCompaniesResponseWrapper> companiesRequest(
      @Body() MdomCompaniesRequestWrapper body);

  @POST('/info/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<MdomInfoSupplierResponseWrapper> infoSupplierRequest(
      @Body() MdomInfoSupplierRequestWrapper body);

  @POST('/info/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<MdomAccountRegistrationResponseWrapper> accountRegistrationRequest(
      @Body() MdomAccountRegistrationRequestWrapper body);

  @POST('/info/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<MdomAccountStatementResponseWrapper> accountStatementRequest(
      @Body() MdomAccountStatementRequestWrapper body);
}
