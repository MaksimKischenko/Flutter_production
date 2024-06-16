import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/data/remote/archives_api.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:retrofit/dio.dart';

abstract interface class ArchivesRepository {

  final ArchivesApi archivesApi;
  final DataManager dataManager;

  ArchivesRepository({
    required this.archivesApi,
    required this.dataManager,
  });
  
  Future<Either<Failure, HttpResponse<List<ArchiveDB>>>> getInstances();
}


