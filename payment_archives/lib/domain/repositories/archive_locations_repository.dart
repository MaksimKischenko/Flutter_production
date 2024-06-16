
import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:retrofit/dio.dart';

abstract interface class ArchiveLocationsRepository {

  final ArchiveLocationsApi archiveLocationsApi;
  final DataManager dataManager;

  ArchiveLocationsRepository({
    required this.archiveLocationsApi,
    required this.dataManager,
  });
  
  Future<Either<Failure, HttpResponse<List<ArchiveLocation>>>> getInstances({int? id});

  Future<Either<Failure, HttpResponse<List<ArchiveLocation>>>> saveInstance(ArchiveLocationInsertRequest request);

  Future<Either<Failure, HttpResponse<List<ArchiveLocation>>>> editInstance({
    required ArchiveLocationUpdateRequest request, 
    required int id
  });

  Future<Either<Failure, HttpResponse<List<ArchiveLocation>>>> deleteInstance({required int id});
}


