
import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/repositories.dart';
import 'package:payment_tracking_module/main.dart';
import 'package:retrofit/dio.dart';

class TokenUseCase {
  final TokenRepository tokenRepository;
  final DataManager dataManager;

  TokenUseCase() : 
   dataManager = getIt<TokenRepositoryImpl>().dataManager,
   tokenRepository = getIt<TokenRepositoryImpl>();

  Future<Either<Failure, HttpResponse<TokenBody>>> getTokenRequest({   
    required String grantType,
    String? username,
    String? password,
    String? refreshToken
  }) async => await tokenRepository.getTokenRequest(
      grantType: grantType, 
      username: username,
      password: password,
      refreshToken: refreshToken
    );   
}

