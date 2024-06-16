
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/repositories.dart';
import 'package:retrofit/dio.dart';


class AuditLogRepositoryImpl implements AuditLogRepository {

  @override
  final AuditLogApi auditLogApi;
  
  @override
  final DataManager dataManager;

  const AuditLogRepositoryImpl({
    required this.auditLogApi,
    required this.dataManager,
  });

  @override
  Future<Either<Failure, HttpResponse<List<AuditLog>>>> getInstances({
    int? count,
    int? offset,
    bool sortAscending = true,
    DateTime? dateFrom,
    DateTime? dateTo,
    String? userName     
  }) async{
      try {
        final response =  await auditLogApi.getAudits(
          auth: dataManager.authHeader, 
          count: count,
          offset: offset,
          order: 'log_id.asc',  
          date: dateFrom != null && dateTo != null
              ? '(op_datetime.gte.$dateFrom-00,op_datetime.lte.$dateTo}-00)'
              : null,
          userName: userName?.isNotEmpty ?? false ? 'ilike.*$userName*' : null,          
        );
      return Right(response);   
    } 
    on DioException catch (e) {
      return Left(DioFailure(error: e));
    }   
  }
}
