import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/token_repository.dart';
import 'package:retrofit/retrofit.dart';


class TokenRepositoryImpl implements TokenRepository {

  @override
  final GetTokendApi tokenApi;

  @override
  final DataManager dataManager;  

  TokenRepositoryImpl({
    required this.tokenApi,
    required this.dataManager
  });
  
  @override
  Future<Either<Failure, HttpResponse<TokenBody>>> getTokenRequest({
    required String grantType,
    String? username,
    String? password,
    String? refreshToken
  }) async {

    try {
      final response = await tokenApi.getToken(
        body: LoginUserRequest(
          clientId: TokenRequestData.clietnId.name,
          login: username, 
          refreshToken: refreshToken,
          password: password, 
          grantType: grantType
        )
      );
      if(response.data.accessToken != null) {
        return Right(response);
      } else {
        return Left(
          DioFailure(
            error: DioException(
            requestOptions: RequestOptions(
              responseType: ResponseType.json,     
            ),
            message: response.response.toString(),
            type: DioExceptionType.badResponse
          )
          )
        );
      }
    } 
    on DioException catch (e) {    
      return Left(DioFailure(error: e));
    } 
  }
}