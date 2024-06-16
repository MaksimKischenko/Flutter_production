
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/repositories.dart';
import 'package:retrofit/dio.dart';


class ArchiveStatusRepositoryImpl implements ArchiveStatusRepository {
  @override
  final ArchiveStatusApi archiveStatusApi;
  
  @override
  final DataManager dataManager;

  const ArchiveStatusRepositoryImpl({
    required this.archiveStatusApi,
    required this.dataManager,
  });

  @override
  Future<Either<Failure, HttpResponse<List<ArchiveStatus>>>> getInstances({int? id}) async{
      try {
        final response =  await archiveStatusApi.getArchiveStatus(
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
