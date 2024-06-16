import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/repositories.dart';
import 'package:payment_tracking_module/main.dart';
import 'package:retrofit/dio.dart';

class AuditLogUseCase {
  final AuditLogRepository auditLogRepository;

  AuditLogUseCase() : 
   auditLogRepository = getIt<AuditLogRepositoryImpl>();

   Future<Either<Failure, HttpResponse<List<AuditLog>>>> getInstances({
    int? count,
    int? offset,
    bool sortAscending = true,
    DateTime? dateFrom,
    DateTime? dateTo,
    String? userName 
  }) async => auditLogRepository.getInstances(
      count: count,
      offset: offset,
      sortAscending: sortAscending,
      dateFrom: dateFrom,
      dateTo: dateTo,
      userName: userName
    );  

    void sortValues({
      required List<AuditLog> audits,
      required bool ascending,
      required int sortIndex      
    }) {
      switch (sortIndex) {
        case 0:
          ascending?
          audits.sort((b, a) => (a.logId ?? 0).compareTo(b.logId ?? 0)):
          audits.sort((a, b) => (a.logId ?? 0).compareTo(b.logId ?? 0));
          break;
        case 1:
          ascending?
          audits.sort((b, a) => (a.userId ?? 0).compareTo(b.userId ?? 0)):
          audits.sort((a, b) => (a.userId ?? 0).compareTo(b.userId ?? 0));
          break;
        case 2:
          ascending?
          audits.sort((b, a) => (a.userName ?? '').compareTo(b.userName ?? '')):
          audits.sort((a, b) => (a.userName ?? '').compareTo(b.userName ?? ''));
          break;            
        case 3:
          ascending?
          audits.sort((b, a) => (a.fullUserName ?? '').compareTo(b.fullUserName ?? '')):
          audits.sort((a, b) => (a.fullUserName ?? '').compareTo(b.fullUserName ?? ''));
          break;  
        case 4:
          ascending?
          audits.sort((b, a) => (a.opDateTime ?? DateTime.now()).compareTo(b.opDateTime ?? DateTime.now())):
          audits.sort((a, b) => (a.opDateTime ?? DateTime.now()).compareTo(b.opDateTime ?? DateTime.now()));
          break;  
        case 5:
          ascending?
          audits.sort((b, a) => (a.actionId ?? 0).compareTo(b.actionId ?? 0)):
          audits.sort((a, b) => (a.actionId ?? 0).compareTo(b.actionId ?? 0));
          break;  
        case 6:
          ascending?
          audits.sort((b, a) => (a.opDescr ?? '').compareTo(b.opDescr ?? '')):
          audits.sort((a, b) => (a.opDescr ?? '').compareTo(b.opDescr ?? ''));
          break;  
        case 7:
          ascending?
          audits.sort((b, a) => (a.ipAddress ?? '').compareTo(b.ipAddress ?? '')):
          audits.sort((a, b) => (a.ipAddress ?? '').compareTo(b.ipAddress ?? ''));
          break;                                                    
      }
  }    
}

