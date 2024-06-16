
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/repositories.dart';
import 'package:retrofit/dio.dart';


class UserTypeRepositoryImpl implements UserTypeRepository {

  @override
  final UserTypeApi userTypeApi;
  
  @override
  final DataManager dataManager;

  const UserTypeRepositoryImpl({
    required this.userTypeApi,
    required this.dataManager,
  });

  @override
  Future<Either<Failure, HttpResponse<List<UserType>>>> getInstance() async{
      try {
        final response =  await userTypeApi.getUserType(
          auth: dataManager.authHeader, 
        );
      return Right(response);   
    } 
    on DioException catch (e) {
      return Left(DioFailure(error: e));
    }   
  }
}
