
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/repositories.dart';
import 'package:retrofit/dio.dart';


class MapAllocationsRepositoryImpl implements MapAllocationsRepository {
  @override
  final MapAllocationsApi mapAllocationsApi;
  
  @override
  final DataManager dataManager;

  const MapAllocationsRepositoryImpl({
    required this.mapAllocationsApi,
    required this.dataManager,
  });

  @override
  Future<Either<Failure, HttpResponse<List<MapAllocationData>>>> getInstances({int? id}) async{
      try {
        final response =  await mapAllocationsApi.getMapAllocations(
          auth: dataManager.authHeader, 
          id: id != null ? 'eq.$id' : null, 
          order: 'archive_db_id.asc'            
        );
      return Right(response);   
    } 
    on DioException catch (e) {
      return Left(DioFailure(error: e));
    }   
  }
}
