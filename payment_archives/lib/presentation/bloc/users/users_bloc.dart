import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/use_cases/use_cases.dart';


part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {

  final UsersUseCase useCase;
  
  UsersBloc() 
  : useCase = UsersUseCase(),
  super(UsersLoading()) {
    on<UsersEvent>(_onEvent);
  }

  late List<User> _users;
  late int typeId;

  Future<void>? _onEvent(
    UsersEvent event,
    Emitter<UsersState> emit,
  ) {
    if (event is UsersInit) return  _onUsersInit(event, emit);
    if (event is NewUserUpdateTable) return _onNewUser(event, emit);
    if (event is EditedUserUpdateTable) return _onUpdateUser(event, emit);
    if (event is UsersDeleteUser) return _onDeleteUser(event, emit);
    if (event is UsersSort) return _onSortUser(event, emit);
    return null;
  }


  Future<void> _onUsersInit(
    UsersInit event,
    Emitter<UsersState> emit,
  ) async {

    emit(UsersLoading());
    
    typeId = event.typeId;

    final result = await useCase.getInstances(
      typeId: event.typeId
    );
    await result.fold((failure) {
      emit(UsersError(error: failure.message));
    }, (right) async{
      _users = right.data;
      emit(UsersLoaded(
        users: _users,
        typeId: typeId
      ));
    });   
 }

  Future<void> _onNewUser(
    NewUserUpdateTable event,
    Emitter<UsersState> emit,
  ) async {

    emit(UsersLoading());
    
    _users.insert(0, event.newUser);

    emit(UsersAddUserSuccess());
    
    emit(UsersLoaded(
      users: _users,
      typeId: typeId      
    ));
  }

  Future<void> _onUpdateUser(
    EditedUserUpdateTable event,
    Emitter<UsersState> emit,
  ) async {

    emit(UsersLoading());
    
    final index = _users.indexWhere((e) => e.id == event.user.id);
      if (index > -1) {
        _users[index] = event.user;
      }

    emit(UsersEditUserSuccess());
    
    emit(UsersLoaded(
      users: _users,
      typeId: typeId      
    ));
  }



  Future<void> _onDeleteUser(
    UsersDeleteUser event,
    Emitter<UsersState> emit,
  ) async {

    emit(UsersLoading());

    final result = await useCase.deleteInstance(
      id: event.userId
    );

    await result.fold((failure) {
      emit(UsersError(error: failure.message));
    }, (right) async{
      _users.removeWhere((e) => e.id == event.userId);
      emit(UsersDeleteUserSuccess(
        event.userId
      ));
      emit(UsersLoaded(
        users: _users,
        typeId: typeId        
      ));     
    });
  }


  Future<void> _onSortUser(
    UsersSort event,
    Emitter<UsersState> emit,   
  ) async {

    emit(UsersLoading());

    useCase.sortValues(
      users: _users,
      sortIndex: event.sortIndex,
      ascending: event.ascending
    );

    emit(UsersLoaded(
      users: _users,
      typeId: typeId      
    ));
  }
}


