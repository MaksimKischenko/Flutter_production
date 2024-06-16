import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/use_cases/use_cases.dart';


part 'user_insert_event.dart';
part 'user_insert_state.dart';

class UserInsertBloc extends Bloc<UserInsertEvent, UserInsertState> {

  final UsersUseCase useCase;

  UserInsertBloc() 
  : useCase = UsersUseCase(),
  super(UserInsertLoading()) {
    on<UserInsertEvent>(_onEvent);
  }

  List<UserType> _typesResponse = [];

  Future<void>? _onEvent(
    UserInsertEvent event,
    Emitter<UserInsertState> emit,
  ) {
    if (event is UserInsertInit) return _onUserInsertInit(event, emit);
    if (event is UserInsertRun) return _onUserInsertRun(event, emit);
    return null;
  }

  Future<void> _onUserInsertInit(
    UserInsertInit event,
    Emitter<UserInsertState> emit,    
  ) async {

    final result = await useCase.getUserTypeInstance();

    await result.fold((failure) {
      emit(UserInsertNetworkError(error: failure.message));
    }, (right) async{
      _typesResponse = right.data;
      emit(UserInsertInitial(
        userTypes: _typesResponse,
      )); 
    }); 
  }
  

  Future<void> _onUserInsertRun(
    UserInsertRun event,
    Emitter<UserInsertState> emit,        
  ) async {

    emit(UserInsertLoading());

    final result = await useCase.saveInstance(
      event.userInsertBody
    );

    await result.fold((failure) {
      emit(UserInsertNetworkError(error: failure.message));
      emit(UserInsertInitial(userTypes: _typesResponse));
    }, (right) async {
      emit(UserInsertSuccess(
        user: right.data.first
      )); 
    }); 
  }
}
