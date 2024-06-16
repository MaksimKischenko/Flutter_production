import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/repositories.dart';
import 'package:payment_tracking_module/main.dart';
import 'package:retrofit/dio.dart';

class ArchiveDBUseCase {
  final ArchivesRepository archivesRepository;

  ArchiveDBUseCase() : 
   archivesRepository = getIt<ArchivesRepositoryImpl>();

  Future<Either<Failure, HttpResponse<List<ArchiveDB>>>> getInstances() => archivesRepository.getInstances();

  void sortValues({
    required List<ArchiveDB> archives,
    required bool ascending,
    required int sortIndex
  }) {
      switch (sortIndex) {
        case 1:
          ascending?
          archives.sort((b, a) => (a.id).compareTo(b.id)):
          archives.sort((a, b) => (a.id).compareTo(b.id));
          break;
        case 2:
          ascending?
          archives.sort((b, a) => (a.caption ?? '').compareTo(b.caption ?? '')):
          archives.sort((a, b) => (a.caption ?? '').compareTo(b.caption ?? ''));
          break;         
        case 3:
          ascending?
          archives.sort((b, a) => (a.createDate ?? DateTime.now()).compareTo(b.createDate ?? DateTime.now())):
          archives.sort((a, b) => (a.createDate ?? DateTime.now()).compareTo(b.createDate ?? DateTime.now()));
          break;
        case 4:
          ascending?
          archives.sort((b, a) => (a.sourceId ?? 0).compareTo(b.sourceId ?? 0)):
          archives.sort((a, b) => (a.sourceId ?? 0).compareTo(b.sourceId ?? 0));
          break; 
        case 5:
          ascending?
          archives.sort((b, a) => (a.statusSortIndex).compareTo(b.statusSortIndex)):
          archives.sort((a, b) => (a.statusSortIndex).compareTo(b.statusSortIndex));
          break;    
        case 6:
          ascending?
          archives.sort((b, a) => (a.statusId ?? 0).compareTo(b.statusId ?? 0)):
          archives.sort((a, b) => (a.statusId ?? 0).compareTo(b.statusId ?? 0));
          break;  
        case 7:
          ascending?
          archives.sort((b, a) => (a.sourceArchiveId ?? 0).compareTo(b.sourceArchiveId ?? 0)):
          archives.sort((a, b) => (a.sourceArchiveId ?? 0).compareTo(b.sourceArchiveId ?? 0));
          break; 
        case 8:
          ascending?
          archives.sort((b, a) => (a.partCount ?? 0).compareTo(b.partCount ?? 0)):
          archives.sort((a, b) => (a.partCount ?? 0).compareTo(b.partCount ?? 0));
          break;                                                                          
      }    
  }   
}

