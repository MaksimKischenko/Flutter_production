import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/repositories.dart';
import 'package:retrofit/dio.dart';


class ArchiveLocationsRepositoryImpl implements ArchiveLocationsRepository {

  @override
  final ArchiveLocationsApi archiveLocationsApi;
  
  @override
  final DataManager dataManager;

  const ArchiveLocationsRepositoryImpl({
    required this.archiveLocationsApi,
    required this.dataManager,
  });

  @override
  Future<Either<Failure, HttpResponse<List<ArchiveLocation>>>> getInstances({int? id}) async{
    try {
      final response =  await archiveLocationsApi.getArchiveLocations(
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
  Future<Either<Failure, HttpResponse<List<ArchiveLocation>>>> saveInstance(
    ArchiveLocationInsertRequest request
  ) async{
    try {
      final response =  await archiveLocationsApi.saveArchiveLocation(
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
  Future<Either<Failure, HttpResponse<List<ArchiveLocation>>>> editInstance({
    required ArchiveLocationUpdateRequest request, 
    required int id
  }) async{
      try {
        final response = await archiveLocationsApi.editArchiveLocation(
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
  Future<Either<Failure, HttpResponse<List<ArchiveLocation>>>> deleteInstance({required int id}) async{
    try {
      final response = await archiveLocationsApi.deleteArchiveLocation(
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
