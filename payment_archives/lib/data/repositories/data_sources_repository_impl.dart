import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/repositories.dart';
import 'package:retrofit/dio.dart';


class DataSourcesRepositoryImpl implements DataSourcesRepository {

  @override
  final DataSourcesApi dataSourcesApi;
  
  @override
  final DataManager dataManager;

  const DataSourcesRepositoryImpl({
    required this.dataSourcesApi,
    required this.dataManager,
  });

  @override
  Future<Either<Failure, HttpResponse<List<DataSource>>>> getInstances({int? id}) async{
    try {
      final response =  await dataSourcesApi.getDataSources(
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
  Future<Either<Failure, HttpResponse<List<DataSource>>>> saveInstance(DataSourceInsertRequest request) async{
    try {
      final response =  await dataSourcesApi.saveDataSources(
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
  Future<Either<Failure, HttpResponse<List<DataSource>>>> editInstance({required DataSourceUpdateRequest request, required int id}) async{
    try {
      final response = await dataSourcesApi.editDataSources(
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
  Future<Either<Failure, HttpResponse<List<DataSource>>>> deleteInstance({required int id}) async{
    try {
      final response = await dataSourcesApi.deleteDataSources(
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
  
