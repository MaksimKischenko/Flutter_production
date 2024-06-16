import 'package:either_dart/either.dart';

import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:retrofit/dio.dart';

abstract interface class ArchiveStatusRepository {

  final ArchiveStatusApi archiveStatusApi;
  final DataManager dataManager;

  ArchiveStatusRepository({
    required this.archiveStatusApi,
    required this.dataManager,
  });
  
  Future<Either<Failure, HttpResponse<List<ArchiveStatus>>>> getInstances({int? id});
}


