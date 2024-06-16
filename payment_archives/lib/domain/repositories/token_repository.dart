import 'package:either_dart/either.dart';

import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:retrofit/dio.dart';

abstract interface class TokenRepository {

  final GetTokendApi tokenApi;
  final DataManager dataManager;

  TokenRepository({
    required this.dataManager,
    required this.tokenApi,
  });
  
  Future<Either<Failure, HttpResponse<TokenBody>>> getTokenRequest({   
    required String grantType,
    String? username,
    String? password,
    String? refreshToken
  });
}
