
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/repositories.dart';
import 'package:retrofit/dio.dart';


class InfoReportsRepositoryImpl implements InfoReportsRepository {
  @override
  final InfoReportsApi infoReportsApi;
  
  @override
  final DataManager dataManager;

  const InfoReportsRepositoryImpl({
    required this.infoReportsApi,
    required this.dataManager,
  });

  @override
  Future<Either<Failure, HttpResponse<String>>> getCurrences({required CurrencyRequest request}) async{
    try {
      final response = await infoReportsApi.curr2word(
        auth: dataManager.authHeader, 
        body: request      
      );
    return Right(response);   
    } 
    on DioException catch (e) {
      return Left(DioFailure(error: e));
    } 
  }
  
  @override
  Future<Either<Failure, HttpResponse<String>>> getPaymentsAttr({required PaymentAtrrRequest request}) async{
    try {
      final response = await infoReportsApi.paymentAttrRequest(
        auth: dataManager.authHeader, 
        body: request      
      );
    return Right(response);   
    } 
    on DioException catch (e) {
      return Left(DioFailure(error: e));
    } 
  }
}
