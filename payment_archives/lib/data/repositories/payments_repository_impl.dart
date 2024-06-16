
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/repositories.dart';
import 'package:retrofit/dio.dart';


class PaymentsRepositiryImpl implements PaymentsRepositiry {
  @override
  final PaymentsApi paymentsApi;
  
  @override
  final DataManager dataManager;

  const PaymentsRepositiryImpl({
    required this.paymentsApi,
    required this.dataManager,
  });

  @override
  Future<Either<Failure, HttpResponse<String>>> prepearInstances({
    required SearchPaymentData request, 
    required SearchPaymentMethod searchPaymentMethod
  }) async{
      switch (searchPaymentMethod) {
        case SearchPaymentMethod.full:
          try {
              final response =  await paymentsApi.searchPaymentFullInit(
                auth: dataManager.authHeader, 
                body: request      
              );
            return Right(response);   
          } 
          on DioException catch (e) {
            return Left(DioFailure(error: e));
          }     
        case SearchPaymentMethod.ids:
          try {
              final response =  await paymentsApi.searchPaymentIdsInit(
                auth: dataManager.authHeader, 
                body: request      
              );
            return Right(response);   
          } 
          on DioException catch (e) {
            return Left(DioFailure(error: e));
          }   
        case SearchPaymentMethod.names:
          try {
              final response =  await paymentsApi.searchPaymentNamesInit(
                auth: dataManager.authHeader, 
                body: request      
              );
            return Right(response);   
          } 
          on DioException catch (e) {
            return Left(DioFailure(error: e));
          }                           
      default:
        try {
          return Right(HttpResponse(
            '', 
            Response(requestOptions: RequestOptions())
            )
          );   
        } 
        on DioException catch (e) {
          return Left(DioFailure(error: e));
        }         
    }
  }
  
  @override
  Future<Either<Failure, HttpResponse<List<Payment>>>> getInstances({required FinalSearchPaymentRequest request}) async{
      try {
        final response =  await paymentsApi.searchPaymentResult(
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
