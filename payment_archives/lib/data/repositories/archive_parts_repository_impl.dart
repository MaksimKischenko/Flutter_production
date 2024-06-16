
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/repositories.dart';
import 'package:retrofit/dio.dart';


class ArchivePartsRepositoryImpl implements ArchivePartsRepository {
  @override
  final ArchivePartsApi archivePartsApi;
  
  @override
  final DataManager dataManager;

  const ArchivePartsRepositoryImpl({
    required this.archivePartsApi,
    required this.dataManager,
  });

  @override
  Future<Either<Failure, HttpResponse<List<ArchiveDBPart>>>> getInstances({int? id}) async{
      try {
        final response =  await archivePartsApi.getArchiveParts(
          auth: dataManager.authHeader, 
          id: id != null ? 'eq.$id' : null,          
        );
      return Right(response);   
    } 
    on DioException catch (e) {
      return Left(DioFailure(error: e));
    }   
  }
}
