import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/repositories.dart';
import 'package:payment_tracking_module/main.dart';
import 'package:retrofit/dio.dart';

class DataSourceUseCase {
  final DataSourcesRepository dataSourceRepository;

  DataSourceUseCase() : 
   dataSourceRepository = getIt<DataSourcesRepositoryImpl>();

  Future<Either<Failure, HttpResponse<List<DataSource>>>> getInstances({int? id}) async => 
  await dataSourceRepository.getInstances(id: id);

  Future<Either<Failure, HttpResponse<List<DataSource>>>> saveInstance(DataSourceInsertRequest request) async => 
  await dataSourceRepository.saveInstance(request);

  Future<Either<Failure, HttpResponse<List<DataSource>>>> editInstance({
    required DataSourceUpdateRequest request, 
    required int id
  }) async => await dataSourceRepository.editInstance(request: request, id: id);

  Future<Either<Failure, HttpResponse<List<DataSource>>>> deleteInstance({required int id}) async => 
  await dataSourceRepository.deleteInstance(id: id);   

  void sortValues({
    required List<DataSource> dataSources,
    required bool ascending,
    required int sortIndex    
  }) {
    switch (sortIndex) {
      case 1:
        ascending?
        dataSources.sort((b, a) => (a.id).compareTo(b.id)):
        dataSources.sort((a, b) => (a.id).compareTo(b.id));
        break;
      case 2:
        ascending?
        dataSources.sort((b, a) => (a.userId ?? 0).compareTo(b.userId ?? 0)):
        dataSources.sort((a, b) => (a.userId ?? 0).compareTo(b.userId ?? 0));
        break;            
      case 3:
        ascending?
        dataSources.sort((b, a) => (a.login ?? '').compareTo(b.login ?? '')):
        dataSources.sort((a, b) => (a.login ?? '').compareTo(b.login ?? ''));
        break;  
      case 4:
        ascending?
        dataSources.sort((b, a) => (a.createDate ?? DateTime.now()).compareTo(b.createDate ?? DateTime.now())):
        dataSources.sort((a, b) => (a.createDate ?? DateTime.now()).compareTo(b.createDate ?? DateTime.now()));
        break;           
      case 5:
        ascending?
        dataSources.sort((b, a) => (a.caption ?? '').compareTo(b.caption ?? '')):
        dataSources.sort((a, b) => (a.caption ?? '').compareTo(b.caption ?? ''));
        break;  
      case 6:
        ascending?
        dataSources.sort((b, a) => (a.dataScale ?? 0).compareTo(b.dataScale ?? 0)):
        dataSources.sort((a, b) => (a.dataScale ?? 0).compareTo(b.dataScale ?? 0));
        break; 
      case 7:
        ascending?
        dataSources.sort((b, a) => (a.statusSortIndexEnabled).compareTo(b.statusSortIndexEnabled)):
        dataSources.sort((a, b) => (a.statusSortIndexEnabled).compareTo(b.statusSortIndexEnabled));
        break;  
      case 8:
        ascending?
        dataSources.sort((b, a) => (a.statusSortIndexBlocked).compareTo(b.statusSortIndexBlocked)):
        dataSources.sort((a, b) => (a.statusSortIndexBlocked).compareTo(b.statusSortIndexBlocked));
        break;                                                                 
    }  
  }   
}

