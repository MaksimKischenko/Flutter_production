import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:retrofit/dio.dart';

abstract interface class ArchivePartsRepository {

  final ArchivePartsApi archivePartsApi;
  final DataManager dataManager;

  ArchivePartsRepository({
    required this.archivePartsApi,
    required this.dataManager,
  });
  
  Future<Either<Failure, HttpResponse<List<ArchiveDBPart>>>> getInstances({int? id});
}


