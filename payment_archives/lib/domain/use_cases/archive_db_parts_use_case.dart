import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/repositories.dart';
import 'package:payment_tracking_module/main.dart';
import 'package:retrofit/dio.dart';
class ArchiveDBPartsUseCase {
  final ArchivePartsRepository archivePartsRepository;

  ArchiveDBPartsUseCase() : 
   archivePartsRepository = getIt<ArchivePartsRepositoryImpl>();

  Future<Either<Failure, HttpResponse<List<ArchiveDBPart>>>> getInstances({int? id}) => 
  archivePartsRepository.getInstances(id: id);


  void sortValues({
    required List<ArchiveDBPart> archiveParts,
    required bool ascending,
    required int sortIndex
  }) {
      switch (sortIndex) {
        case 1:
          ascending?
          archiveParts.sort((b, a) => a.partId.compareTo(b.partId)):
          archiveParts.sort((a, b) => a.partId.compareTo(b.partId));
          break;
        case 2:
          ascending?
          archiveParts.sort((b, a) => (a.createDate ?? DateTime.now()).compareTo(b.createDate ?? DateTime.now())):
          archiveParts.sort((a, b) => (a.createDate ?? DateTime.now()).compareTo(b.createDate ?? DateTime.now()));
          break;
        case 3:
          ascending?
          archiveParts.sort((b, a) => (a.statusId ?? 0).compareTo(b.statusId ?? 0)):
          archiveParts.sort((a, b) => (a.statusId ?? 0).compareTo(b.statusId ?? 0));
          break;  
        case 4:
          ascending?
          archiveParts.sort((b, a) => (a.updateDate ?? DateTime.now()).compareTo(b.updateDate ?? DateTime.now())):
          archiveParts.sort((a, b) => (a.updateDate ?? DateTime.now()).compareTo(b.updateDate ?? DateTime.now()));
          break;  
        case 5:
          ascending?
          archiveParts.sort((b, a) => (a.rowCount ?? 0).compareTo(b.rowCount ?? 0)):
          archiveParts.sort((a, b) => (a.rowCount ?? 0).compareTo(b.rowCount ?? 0));
          break;                       
      }    
  }
}

