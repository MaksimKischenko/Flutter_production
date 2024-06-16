import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';

// ignore: one_member_abstracts
abstract interface class ReportGenerator{
  Future<Either<Failure, String>> generateReports(FormReportsInit event);
}