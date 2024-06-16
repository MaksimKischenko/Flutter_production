import 'package:either_dart/either.dart';

import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:retrofit/dio.dart';

abstract interface class MapAllocationsRepository {

  final MapAllocationsApi mapAllocationsApi;
  final DataManager dataManager;

  MapAllocationsRepository({
    required this.mapAllocationsApi,
    required this.dataManager,
  });
  
  Future<Either<Failure, HttpResponse<List<MapAllocationData>>>> getInstances({int? id});
}


