import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/repositories.dart';
import 'package:payment_tracking_module/main.dart';
import 'package:retrofit/dio.dart';

class ArchiveStatusUseCase {
  final ArchiveStatusRepository archiveStatusRepository;

  ArchiveStatusUseCase() : 
   archiveStatusRepository = getIt<ArchiveStatusRepositoryImpl>();

  Future<Either<Failure, HttpResponse<List<ArchiveStatus>>>> getInstances({int? id}) async 
  => archiveStatusRepository.getInstances(id: id); 

void sortValues({
    required List<ArchiveStatus> archiveStatuses,
    required bool ascending,
    required int sortIndex
  }) {
      switch (sortIndex) {
        case 0:
          ascending?
          archiveStatuses.sort((b, a) => a.id.compareTo(b.id)):
          archiveStatuses.sort((a, b) => a.id.compareTo(b.id));
          break;
        case 1:
          ascending?
          archiveStatuses.sort((b, a) => a.caption.compareTo(b.caption)):
          archiveStatuses.sort((a, b) => a.caption.compareTo(b.caption));
          break;                     
      }
  }       
}

