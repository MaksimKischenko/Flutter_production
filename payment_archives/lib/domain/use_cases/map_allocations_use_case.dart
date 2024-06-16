import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/repositories.dart';
import 'package:payment_tracking_module/main.dart';
import 'package:retrofit/dio.dart';

class MapAllocationsUseCase {
  final MapAllocationsRepository mapAllocationsRepository;

  MapAllocationsUseCase() : 
   mapAllocationsRepository = getIt<MapAllocationsRepositoryImpl>();

  Future<Either<Failure, HttpResponse<List<MapAllocationData>>>> getInstances({int? id}) async => 
  await mapAllocationsRepository.getInstances();  

  void sortValues({
    required List<MapAllocationData> mapAllocations,
    required bool ascending,
    required int sortIndex    
  }) {
      switch (sortIndex) {
        case 0:
          ascending?
          mapAllocations.sort((b, a) => (a.archiveId).compareTo(b.archiveId)):
          mapAllocations.sort((a, b) => (a.archiveId).compareTo(b.archiveId));
          break;
        case 1:
          ascending?
          mapAllocations.sort((b, a) => (a.locationId ?? 0).compareTo(b.locationId ?? 0)):
          mapAllocations.sort((a, b) => (a.locationId ?? 0).compareTo(b.locationId ?? 0));
          break;
        case 2:
          ascending?
          mapAllocations.sort((b, a) => (a.statusSortIndex).compareTo(b.statusSortIndex)):
          mapAllocations.sort((a, b) => (a.statusSortIndex).compareTo(b.statusSortIndex));
          break;            
        case 4:
          ascending?
          mapAllocations.sort((b, a) => (a.storeDate ?? DateTime.now()).compareTo(b.storeDate ?? DateTime.now())):
          mapAllocations.sort((a, b) => (a.storeDate ?? DateTime.now()).compareTo(b.storeDate ?? DateTime.now()));
          break;                                                  
      }
  }  
}

