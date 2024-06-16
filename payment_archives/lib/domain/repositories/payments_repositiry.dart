
import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:retrofit/dio.dart';

abstract interface class PaymentsRepositiry {

  final PaymentsApi paymentsApi;
  final DataManager dataManager;

  PaymentsRepositiry({
    required this.paymentsApi,
    required this.dataManager,
  });
  
  Future<Either<Failure, HttpResponse<String>>> prepearInstances({required SearchPaymentData request, required SearchPaymentMethod searchPaymentMethod});

  Future<Either<Failure, HttpResponse<List<Payment>>>> getInstances({required FinalSearchPaymentRequest request});
}


