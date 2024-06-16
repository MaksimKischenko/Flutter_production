import 'package:dio/dio.dart' hide Headers;
import 'package:payment_tracking_module/data/data.dart';
import 'package:retrofit/retrofit.dart';



part 'rule_allocation_data_api.g.dart';

@RestApi() 
abstract interface class RuleAllocationDataApi {
  factory RuleAllocationDataApi(Dio dio, {String baseUrl}) = _RuleAllocationDataApi;


  @GET('/rule_allocation_data')
  Future<HttpResponse<List<RuleAllocationData>>> getRuleAllocationData({
    @Header('Authorization') required String auth,
    @Query('id') required String? id,
    @Query('order') String? order
  });

  @POST('/rule_allocation_data')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<HttpResponse<List<RuleAllocationData>>> saveRuleAllocationData({
    @Header('Authorization') required String auth,
    @Body() required RuleAllocationInsertRequest body
  });

  @PATCH('/rule_allocation_data')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<HttpResponse<List<RuleAllocationData>>> editRuleAllocationData({
    @Header('Authorization') required String auth,
    @Query('id') required String id,
    @Body() required RuleAllocationUpdateRequest body
  });

 @DELETE('/rule_allocation_data')
  @Headers(<String, dynamic>{
    'Prefer': 'return=representation',
  })
  Future<HttpResponse<List<RuleAllocationData>>> deleteRuleAllocationData({
    @Header('Authorization') required String auth,
    @Query('id') required String id
  });
}







 