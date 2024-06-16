import 'package:either_dart/either.dart';

import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:retrofit/dio.dart';

abstract interface class ChangePasswordRepository {

  final ChangePasswordApi changePasswordApi;
  final DataManager dataManager;
  
  ChangePasswordRepository({
    required this.changePasswordApi,
    required this.dataManager,
  });
  
  Future<Either<Failure, HttpResponse<ChangePasswordResponse>>> getNewPassword({
    String oldPassword, 
    String newPassword
  });
}
