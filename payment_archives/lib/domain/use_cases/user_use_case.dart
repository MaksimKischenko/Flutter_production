import 'package:either_dart/either.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/failure.dart';
import 'package:payment_tracking_module/domain/repositories/repositories.dart';
import 'package:payment_tracking_module/main.dart';
import 'package:retrofit/dio.dart';

class UsersUseCase {
  final UsersRepository usersRepository;
  final UserTypeRepository userTypeRepository;  

  UsersUseCase() : 
   usersRepository = getIt<UsersRepositoryImpl>(),
   userTypeRepository = getIt<UserTypeRepositoryImpl>();

  Future<Either<Failure, HttpResponse<List<User>>>> getInstances({int? id, int? typeId}) async =>
    await usersRepository.getInstances(id: id, typeId: typeId);

  Future<Either<Failure, HttpResponse<List<User>>>> saveInstance(UserInsertRequest request) async => 
    await usersRepository.saveInstance(request);

  Future<Either<Failure, HttpResponse<List<User>>>> editInstance({
    required UserUpdateRequest request, 
    required int id
  }) async => await usersRepository.editInstance(request: request, id: id);

  Future<Either<Failure, HttpResponse<List<User>>>> deleteInstance({required int id}) async => 
    await usersRepository.deleteInstance(id: id); 

  Future<Either<Failure, HttpResponse<List<UserType>>>> getUserTypeInstance() async => 
    await userTypeRepository.getInstance();  

  void sortValues({
    required List<User> users,
    required bool ascending,
    required int sortIndex    
  }) {
      switch (sortIndex) {
        case 1:
          ascending?
          users.sort((b, a) => (a.name ?? '').compareTo(b.name ?? '')):
          users.sort((a, b) => (a.name ?? '').compareTo(b.name ?? ''));
          break;
        case 2:
          ascending?
          users.sort((b, a) => (a.login ?? '').compareTo(b.login ?? '')):
          users.sort((a, b) => (a.login ?? '').compareTo(b.login ?? ''));
          break;            
        case 3:
          ascending?
          users.sort((b, a) => (a.description ?? '').compareTo(b.description ?? '')):
          users.sort((a, b) => (a.description ?? '').compareTo(b.description ?? ''));
          break;  
        case 4:
          ascending?
          users.sort((b, a) => (a.statusSortIndex).compareTo(b.statusSortIndex)):
          users.sort((a, b) => (a.statusSortIndex).compareTo(b.statusSortIndex));
          break;  
        case 5:
          ascending?
          users.sort((b, a) => (a.dateAdd ?? DateTime.now()).compareTo(b.dateAdd ?? DateTime.now())):
          users.sort((a, b) => (a.dateAdd ?? DateTime.now()).compareTo(b.dateAdd ?? DateTime.now()));
          break;                                                   
      }
  }
}

