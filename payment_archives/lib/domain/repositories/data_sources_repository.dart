import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:retrofit/dio.dart';

abstract interface class DataSourcesRepository {

  final DataSourcesApi dataSourcesApi;
  final DataManager dataManager;

  DataSourcesRepository({
    required this.dataSourcesApi,
    required this.dataManager,
  });
  
  Future<Either<Failure, HttpResponse<List<DataSource>>>> getInstances({int? id});

  Future<Either<Failure, HttpResponse<List<DataSource>>>> saveInstance(DataSourceInsertRequest request);

  Future<Either<Failure, HttpResponse<List<DataSource>>>> editInstance({
    required DataSourceUpdateRequest request, 
    required int id
  });

  Future<Either<Failure, HttpResponse<List<DataSource>>>> deleteInstance({required int id});
}


