
import 'package:either_dart/either.dart';

import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:retrofit/dio.dart';

abstract interface class AvailableArchiveLocationRepository {

  final AvailableArchiveLocationsApi availableArchiveLocationsApi;
  final DataManager dataManager;

  AvailableArchiveLocationRepository({
    required this.availableArchiveLocationsApi,
    required this.dataManager,
  });
  
  Future<Either<Failure, HttpResponse<List<AvailableArchiveLocation>>>> getInstances({int? id});
}


