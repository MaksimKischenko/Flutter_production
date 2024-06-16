import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/repositories.dart';
import 'package:retrofit/dio.dart';


class UsersRepositoryImpl implements UsersRepository {

  @override
  final UsersApi usersApi;
  
  @override
  final DataManager dataManager;

  const UsersRepositoryImpl({
    required this.usersApi,
    required this.dataManager,
  });

  @override
  Future<Either<Failure, HttpResponse<List<User>>>> getInstances({int? id, int? typeId}) async{
    try {
      final response = await usersApi.getUsers(
        auth: dataManager.authHeader,
        id: id != null ? 'eq.$id' : null,
        typeId: typeId != null ? 'eq.$typeId' : null, 
        order: 'user_id.asc'   
      );
      return Right(response);   
    } 
    on DioException catch (e) {
      return Left(DioFailure(error: e));
    }   
  }

  @override
  Future<Either<Failure, HttpResponse<List<User>>>> saveInstance(
    UserInsertRequest request
  ) async{
    try {
      final response =  await usersApi.saveUser(
        auth: dataManager.authHeader, 
        body: request
      );
      return Right(response);   
    } 
    on DioException catch (e) {
      return Left(DioFailure(error: e));
    }   
  }

  @override
  Future<Either<Failure, HttpResponse<List<User>>>> editInstance({
    required UserUpdateRequest request, 
    required int id
  }) async{
      try {
        final response = await usersApi.editUser(
          auth: dataManager.authHeader, 
          id: 'eq.$id',
          body: request
        );
        return Right(response);   
      } 
      on DioException catch (e) {
        return Left(DioFailure(error: e));
      }   
  }

  @override
  Future<Either<Failure, HttpResponse<List<User>>>> deleteInstance({required int id}) async{
    try {
      final response = await usersApi.deleteUser(
        auth: dataManager.authHeader, 
        id: 'eq.$id',
      );
      return Right(response);   
    } 
    on DioException catch (e) {
      return Left(DioFailure(error: e));
    }  
  }
}
