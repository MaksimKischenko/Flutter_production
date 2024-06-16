import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:retrofit/dio.dart';

abstract interface class RuleAllocationDataRepository {

  final RuleAllocationDataApi ruleAllocationDataApi;
  final DataManager dataManager;

  RuleAllocationDataRepository({
    required this.ruleAllocationDataApi,
    required this.dataManager,
  });
  
  Future<Either<Failure, HttpResponse<List<RuleAllocationData>>>> getInstances({int? id});

  Future<Either<Failure, HttpResponse<List<RuleAllocationData>>>> saveInstance(RuleAllocationInsertRequest request);

  Future<Either<Failure, HttpResponse<List<RuleAllocationData>>>> editInstance({
    required RuleAllocationUpdateRequest request, 
    required int id
  });

  Future<Either<Failure, HttpResponse<List<RuleAllocationData>>>> deleteInstance({required int id});
}


