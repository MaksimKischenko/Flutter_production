import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/repositories.dart';
import 'package:payment_tracking_module/main.dart';
import 'package:retrofit/dio.dart';

class AvaliableArchiveLocationsUseCase {
  final AvailableArchiveLocationRepository availableArchiveLocationRepository;

  AvaliableArchiveLocationsUseCase() : 
   availableArchiveLocationRepository = getIt<AvailableArchiveLocationRepositoryImpl>();

  Future<Either<Failure, HttpResponse<List<AvailableArchiveLocation>>>> getInstances({int? id}) async 
  => availableArchiveLocationRepository.getInstances(id: id);  

  void sortValues({
    required List<AvailableArchiveLocation> availableArchiveLocations,
    required bool ascending,
    required int sortIndex
  }) {
      switch (sortIndex) {
        case 0:
          ascending?
          availableArchiveLocations.sort((b, a) => (a.sourceId ?? 0).compareTo(b.sourceId ?? 0)):
          availableArchiveLocations.sort((a, b) => (a.sourceId ?? 0).compareTo(b.sourceId ?? 0));
          break;
        case 1:
          ascending?
          availableArchiveLocations.sort((b, a) => (a.id ?? 0).compareTo(b.id ?? 0)):
          availableArchiveLocations.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
          break;
        case 2:
          ascending?
          availableArchiveLocations.sort((b, a) => (a.createDate ?? DateTime.now()).compareTo(b.createDate ?? DateTime.now())):
          availableArchiveLocations.sort((a, b) => (a.createDate ?? DateTime.now()).compareTo(b.createDate ?? DateTime.now()));
          break;           
        case 3:
          ascending?
          availableArchiveLocations.sort((b, a) => (a.caption ?? '').compareTo(b.caption ?? '')):
          availableArchiveLocations.sort((a, b) => (a.caption ?? '').compareTo(b.caption ?? ''));
          break;            
        case 4:
          ascending?
          availableArchiveLocations.sort((b, a) => (a.connectionHost ?? '').compareTo(b.connectionHost ?? '')):
          availableArchiveLocations.sort((a, b) => (a.connectionHost ?? '').compareTo(b.connectionHost ?? ''));
          break;  
        case 5:
          ascending?
          availableArchiveLocations.sort((b, a) => (a.connectionPort ?? 0).compareTo(b.connectionPort ?? 0)):
          availableArchiveLocations.sort((a, b) => (a.connectionPort ?? 0).compareTo(b.connectionPort ?? 0));
          break;  
        case 6:
          ascending?
          availableArchiveLocations.sort((b, a) => (a.connectionUser ?? '').compareTo(b.connectionUser ?? '')):
          availableArchiveLocations.sort((a, b) => (a.connectionUser ?? '').compareTo(b.connectionUser ?? ''));
          break;  
        case 7:
          ascending?
          availableArchiveLocations.sort((b, a) => (a.databaseName ?? '').compareTo(b.databaseName ?? '')):
          availableArchiveLocations.sort((a, b) => (a.databaseName ?? '').compareTo(b.databaseName ?? ''));
          break;    
        case 8:
          ascending?
          availableArchiveLocations.sort((b, a) => (a.statusSortIndex).compareTo(b.statusSortIndex)):
          availableArchiveLocations.sort((a, b) => (a.statusSortIndex).compareTo(b.statusSortIndex));
          break;                                                             
      }
  } 
}

