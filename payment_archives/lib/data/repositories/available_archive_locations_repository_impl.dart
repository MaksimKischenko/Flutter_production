
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/repositories.dart';
import 'package:retrofit/dio.dart';


class AvailableArchiveLocationRepositoryImpl implements AvailableArchiveLocationRepository {
  @override
  final AvailableArchiveLocationsApi availableArchiveLocationsApi;
  
  @override
  final DataManager dataManager;

  const AvailableArchiveLocationRepositoryImpl({
    required this.availableArchiveLocationsApi,
    required this.dataManager,
  });

  @override
  Future<Either<Failure, HttpResponse<List<AvailableArchiveLocation>>>> getInstances({int? id}) async{
      try {
        final response =  await availableArchiveLocationsApi.getAvailableArchiveLocations(
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
}
