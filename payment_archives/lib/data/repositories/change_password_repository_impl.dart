import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/change_password_repository.dart';
import 'package:retrofit/dio.dart';

class ChangePasswordRepositoryImpl implements ChangePasswordRepository {

  @override
  final ChangePasswordApi changePasswordApi;
  
  @override
  final DataManager dataManager;

  const ChangePasswordRepositoryImpl({
    required this.changePasswordApi,
    required this.dataManager,
  });
  
  @override
  Future<Either<Failure, HttpResponse<ChangePasswordResponse>>> getNewPassword({
    String? oldPassword,
    String? newPassword
  }) async{

    try {
      final response = await changePasswordApi.getNewPassword(
        auth: dataManager.authHeader, 
        body: ChangePasswordRequest(
          oldPassword: oldPassword!, 
          newPassword: newPassword!
        )
      );
        return Right(response);
      } 
      on DioException catch (e) {
        return Left(DioFailure(error: e));
     } 
  }
}
