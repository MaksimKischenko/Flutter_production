import 'package:bpc/data/data.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'komplat_api.g.dart';

@RestApi()
abstract class KomplatApi {
  factory KomplatApi(Dio dio, {String baseUrl}) = _KomplatApi;

  @POST('/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<PsTpOInformationResponseWrapper> informationRequest(
    @Body() PsTpOInformationRequestWrapper body,
  );

  @POST('/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<PsTpOClaimsListResponseWrapper> claimsListRequest(
    @Body() PsTpOClaimsListRequestWrapper body,
  );

  @POST('/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<PsTpODeleteClaimResponseWrapper> deleteClaimRequest(
    @Body() PsTpODeleteClaimRequestWrapper body,
  );

  @POST('/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<PsTpOAddClaimResponseWrapper> addClaimRequest(
    @Body() PsTpOAddClaimRequestWrapper body,
  );

  @POST('/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<PsTpOPaymentsListResponseWrapper> paymentsListRequest(
    @Body() PsTpOPaymentsListRequestWrapper body,
  );

  @POST('/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<PsTpOServicesListResponseWrapper> servicesListRequest(
    @Body() PsTpOServicesListRequestWrapper body,
  );

  @POST('/online.request')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json; charset=UTF-8',
  })
  Future<PsTpOAlgorithmListResponseWrapper> algorithmListRequest(
    @Body() PsTpOAlgorithmListRequestWrapper body,
  );
}
