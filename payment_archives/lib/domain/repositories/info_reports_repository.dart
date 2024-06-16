import 'package:either_dart/either.dart';

import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:retrofit/dio.dart';

abstract interface class InfoReportsRepository {

  final InfoReportsApi infoReportsApi;
  final DataManager dataManager;

  InfoReportsRepository({
    required this.infoReportsApi,
    required this.dataManager,
  });
  
  Future<Either<Failure, HttpResponse<String>>> getPaymentsAttr({required PaymentAtrrRequest request});

  Future<Either<Failure, HttpResponse<String>>> getCurrences({required CurrencyRequest request});
}


