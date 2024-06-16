import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/repositories.dart';
import 'package:payment_tracking_module/main.dart';
import 'package:retrofit/dio.dart';

class InfoReportsUseCase {
  final InfoReportsRepository infoReportsRepository;

  InfoReportsUseCase() : 
   infoReportsRepository = getIt<InfoReportsRepositoryImpl>();

  Future<Either<Failure, HttpResponse<String>>> getPaymentsAttr({required PaymentAtrrRequest request}) async => 
  await infoReportsRepository.getPaymentsAttr(request: request);

  Future<Either<Failure, HttpResponse<String>>> getCurrences({required CurrencyRequest request}) async => 
  await infoReportsRepository.getCurrences(request: request);  
}

