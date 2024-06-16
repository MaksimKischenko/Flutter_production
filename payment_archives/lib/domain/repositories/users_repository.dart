import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:retrofit/dio.dart';

abstract interface class UsersRepository {

  final UsersApi usersApi;
  final DataManager dataManager;

  UsersRepository({
    required this.usersApi,
    required this.dataManager,
  });
  
  Future<Either<Failure, HttpResponse<List<User>>>> getInstances({int? id, int? typeId});

  Future<Either<Failure, HttpResponse<List<User>>>> saveInstance(UserInsertRequest request);

  Future<Either<Failure, HttpResponse<List<User>>>> editInstance({
    required UserUpdateRequest request, 
    required int id
  });

  Future<Either<Failure, HttpResponse<List<User>>>> deleteInstance({required int id});
}


