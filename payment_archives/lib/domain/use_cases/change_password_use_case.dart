import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/repositories.dart';
import 'package:payment_tracking_module/main.dart';
import 'package:retrofit/dio.dart';


class ChangePasswordUseCase {
  final ChangePasswordRepository changePasswordRepository;

  ChangePasswordUseCase() : 
   changePasswordRepository = getIt<ChangePasswordRepositoryImpl>();

  Future<Either<Failure, HttpResponse<ChangePasswordResponse>>> getNewPassword({
    required String oldPassword, 
    required String newPassword
  }) async => await changePasswordRepository.getNewPassword(
      newPassword: newPassword,
      oldPassword: oldPassword
    );
}

