import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/repositories.dart';
import 'package:retrofit/dio.dart';


class RuleAllocationDataRepositoryImpl implements RuleAllocationDataRepository {

  @override
  final RuleAllocationDataApi ruleAllocationDataApi;
  
  @override
  final DataManager dataManager;

  const RuleAllocationDataRepositoryImpl({
    required this.ruleAllocationDataApi,
    required this.dataManager,
  });

  @override
  Future<Either<Failure, HttpResponse<List<RuleAllocationData>>>> getInstances({int? id}) async{
    try {
      final response =  await ruleAllocationDataApi.getRuleAllocationData(
        auth: dataManager.authHeader, 
        id: id != null ? 'eq.$id' : null,
        order: 'id.asc'    
      );
      return Right(response);   
    } 
    on DioException catch (e) {
      return Left(DioFailure(error: e));
    }   
  }

  @override
  Future<Either<Failure, HttpResponse<List<RuleAllocationData>>>> saveInstance(RuleAllocationInsertRequest request) async{
    try {
      final response =  await ruleAllocationDataApi.saveRuleAllocationData(
        auth: dataManager.authHeader, 
        body: request
      );
      return Right(response);   
    } 
    on DioException catch (e) {
      return Left(DioFailure(error: e));
    }   
  }

  @override
  Future<Either<Failure, HttpResponse<List<RuleAllocationData>>>> editInstance({required RuleAllocationUpdateRequest request, required int id}) async{
    try {
      final response = await ruleAllocationDataApi.editRuleAllocationData(
        auth: dataManager.authHeader, 
        id: 'eq.$id',
        body: request
      );
      return Right(response);   
    } 
    on DioException catch (e) {
      return Left(DioFailure(error: e));
    }  
  }
  

  @override
  Future<Either<Failure, HttpResponse<List<RuleAllocationData>>>> deleteInstance({required int id}) async{
    try {
      final response = await ruleAllocationDataApi.deleteRuleAllocationData(
        auth: dataManager.authHeader, 
        id: 'eq.$id',
      );
      return Right(response);   
    } 
    on DioException catch (e) {
      return Left(DioFailure(error: e));
    }  
  }
}
  
