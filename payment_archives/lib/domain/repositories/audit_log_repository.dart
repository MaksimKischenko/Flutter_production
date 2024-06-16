import 'package:either_dart/either.dart';

import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:retrofit/dio.dart';

abstract interface class AuditLogRepository {

  final AuditLogApi auditLogApi;
  final DataManager dataManager;

  AuditLogRepository({
    required this.auditLogApi,
    required this.dataManager,
  });
  
  Future<Either<Failure, HttpResponse<List<AuditLog>>>> getInstances({
    int? count,
    int? offset,
    bool sortAscending = true,
    DateTime? dateFrom,
    DateTime? dateTo,
    String? userName 
  });
}


