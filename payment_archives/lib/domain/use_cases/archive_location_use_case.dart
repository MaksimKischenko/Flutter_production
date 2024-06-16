import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/repositories.dart';
import 'package:payment_tracking_module/main.dart';
import 'package:retrofit/dio.dart';

class ArchiveLocationUseCase {
  final ArchiveLocationsRepository archiveLocationsRepository;

  ArchiveLocationUseCase() : 
   archiveLocationsRepository = getIt<ArchiveLocationsRepositoryImpl>();

  Future<Either<Failure, HttpResponse<List<ArchiveLocation>>>> getInstances({int? id}) async 
   => await archiveLocationsRepository.getInstances(id: id);

  Future<Either<Failure, HttpResponse<List<ArchiveLocation>>>> saveInstance({
    required ArchiveLocationInsertRequest archiveLocationInsertBody}) async 
   => await archiveLocationsRepository.saveInstance(archiveLocationInsertBody);

  Future<Either<Failure, HttpResponse<List<ArchiveLocation>>>> editInstance({
    required int id,
    required ArchiveLocationUpdateRequest request,
  }) async 
   => await archiveLocationsRepository.editInstance(request: request, id: id);

  Future<Either<Failure, HttpResponse<List<ArchiveLocation>>>> deleteInstance({required int id}) async 
  => await archiveLocationsRepository.deleteInstance(id: id);


void sortValues({
    required List<ArchiveLocation> archiveLocations,
    required bool ascending,
    required int sortIndex
  }) {
      switch (sortIndex) {
        case 1:
          ascending?
          archiveLocations.sort((b, a) => (a.id ?? 0).compareTo(b.id ?? 0)):
          archiveLocations.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
          break;
        case 2:
          ascending?
          archiveLocations.sort((b, a) => (a.createDate ?? DateTime.now()).compareTo(b.createDate ?? DateTime.now())):
          archiveLocations.sort((a, b) => (a.createDate ?? DateTime.now()).compareTo(b.createDate ?? DateTime.now()));
          break;             
        case 3:
          ascending?
          archiveLocations.sort((b, a) => (a.caption ?? '').compareTo(b.caption ?? '')):
          archiveLocations.sort((a, b) => (a.caption ?? '').compareTo(b.caption ?? ''));
          break;            
        case 4:
          ascending?
          archiveLocations.sort((b, a) => (a.connectionHost ?? '').compareTo(b.connectionHost ?? '')):
          archiveLocations.sort((a, b) => (a.connectionHost ?? '').compareTo(b.connectionHost ?? ''));
          break;  
        case 5:
          ascending?
          archiveLocations.sort((b, a) => (a.connectionPort ?? 0).compareTo(b.connectionPort ?? 0)):
          archiveLocations.sort((a, b) => (a.connectionPort ?? 0).compareTo(b.connectionPort ?? 0));
          break;  
        case 6:
          ascending?
          archiveLocations.sort((b, a) => (a.connectionUser ?? '').compareTo(b.connectionUser ?? '')):
          archiveLocations.sort((a, b) => (a.connectionUser ?? '').compareTo(b.connectionUser ?? ''));
          break;     
        case 7:
          ascending?
          archiveLocations.sort((b, a) => (a.databaseName ?? '').compareTo(b.databaseName ?? '')):
          archiveLocations.sort((a, b) => (a.databaseName ?? '').compareTo(b.databaseName ?? ''));
          break; 
        case 8:
          ascending?
          archiveLocations.sort((b, a) => (a.statusSortIndex).compareTo(b.statusSortIndex)):
          archiveLocations.sort((a, b) => (a.statusSortIndex).compareTo(b.statusSortIndex));
          break;                                                          
      }   
  }     
}

