
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data_manager.dart';
import 'package:payment_tracking_module/data/remote/archives_api.dart';
import 'package:payment_tracking_module/data/remote_models/get_archive_db_response.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/repositories.dart';
import 'package:retrofit/dio.dart';


class ArchivesRepositoryImpl implements ArchivesRepository {
  @override
  final ArchivesApi archivesApi;
  
  @override
  final DataManager dataManager;

  const ArchivesRepositoryImpl({
    required this.archivesApi,
    required this.dataManager,
  });

  @override
  Future<Either<Failure, HttpResponse<List<ArchiveDB>>>> getInstances() async{
      try {
        final response =  await archivesApi.getArchives(
          auth: dataManager.authHeader, 
          order: 'id.asc'  
        );
      return Right(response);   
    } 
    on DioException catch (e) {
      return Left(DioFailure(error: e));
    }   
  }
}
