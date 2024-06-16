import 'package:bpc_nkfo/data/data.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'komplat_api.g.dart';

@RestApi()
abstract class KomplatApi {
  factory KomplatApi(Dio dio, {String baseUrl}) = _KomplatApi;

  @GET('/online.request')
  Future<String> testRequest();

  @POST('/online.request')
  Future<PsTpOTokenResponseWrapper> tokenRequest(@Body() PsTpOTokenRequestWrapper body);

  @POST('/online.request')
  Future<PsTpODeleteTokenResponseWrapper> deleteTokenRequest(@Body() PsTpODeleteTokenRequestWrapper body);

  @POST('/online.request')
  Future<PsTpOInformationResponseWrapper> informationRequest(@Body() PsTpOInformationRequestWrapper body);

  @POST('/online.request')
  Future<PsTpOClaimsListResponseWrapper> claimsListRequest(@Body() PsTpOClaimsListRequestWrapper body);

  @POST('/online.request')
  Future<PsTpODeleteClaimResponseWrapper> deleteClaimRequest(@Body() PsTpODeleteClaimRequestWrapper body);

  @POST('/online.request')
  Future<PsTpOAddClaimResponseWrapper> addClaimRequest(@Body() PsTpOAddClaimRequestWrapper body);

  @POST('/online.request')
  Future<PsTpOSupplierStatusResponseWrapper> supplierStatusRequest(@Body() PsTpOSupplierStatusRequestWrapper body);

  @POST('/online.request')
  Future<PsTpOPaymentsListResponseWrapper> paymentsListRequest(@Body() PsTpOPaymentsListRequestWrapper body);

  @POST('/online.request')
  Future<PsTpOServicesListResponseWrapper> servicesListRequest(@Body() PsTpOServicesListRequestWrapper body);

  @POST('/online.request')
  Future<PsTpOAlgorithmListResponseWrapper> algorithmListRequest(@Body() PsTpOAlgorithmListRequestWrapper body);

}