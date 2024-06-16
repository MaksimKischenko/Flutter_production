import 'package:either_dart/either.dart';

import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:retrofit/dio.dart';

abstract interface class UserTypeRepository {

  final UserTypeApi userTypeApi;
  final DataManager dataManager;

  UserTypeRepository({
    required this.userTypeApi,
    required this.dataManager,
  });
  
  Future<Either<Failure, HttpResponse<List<UserType>>>> getInstance();
}


