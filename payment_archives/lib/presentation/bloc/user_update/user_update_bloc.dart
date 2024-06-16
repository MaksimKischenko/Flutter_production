import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/use_cases/use_cases.dart';


part 'user_update_event.dart';
part 'user_update_state.dart';

class UserUpdateBloc extends Bloc<UserUpdateEvent, UserUpdateState> {

  final UsersUseCase useCase;
  final int? id;
  User? user;
 

  UserUpdateBloc({
    required this.id,
    required this.user
  }) 
  : useCase = UsersUseCase(),
  super(UserUpdateLoading()) {
    on<UserUpdateEvent>(_onEvent);
  }

  List<UserType> _typesResponse = [];

  Future<void>? _onEvent(
    UserUpdateEvent event,
    Emitter<UserUpdateState> emit,
  ) {
    if (event is UserUpdateInit) return _onUserUpdateInit(event, emit);
    if (event is UserUpdateRun) return _onUserUpdateRun(event, emit);
    return null;
  }

  Future<void> _onUserUpdateInit(
    UserUpdateInit event,
    Emitter<UserUpdateState> emit,       
  ) async {

      final result = await useCase.getUserTypeInstance();

      await result.fold((failure) {
        emit(UserUpdateNetworkError(error: failure.message));
      }, (right) async{
        _typesResponse = right.data; 
      }); 

      if(user?.id == 0) {

        final result = await useCase.getInstances(
          id: id
        );
        await result.fold((failure) {
          emit(UserUpdateNetworkError(error: failure.message));
        }, (right) async{
          user = right.data.first;
        });  
      }
      emit(UserUpdateInitial(
        user: user,
        userTypes: _typesResponse
      ));
  }

  Future<void> _onUserUpdateRun(
    UserUpdateRun event,
    Emitter<UserUpdateState> emit,        
  ) async {

    emit(UserUpdateLoading());

    final result = await useCase.editInstance(
      request: event.user,
      id: id ?? 0
    );

    await result.fold((failure) {
      emit(UserUpdateNetworkError(
        error: failure.message
      ));
      emit(UserUpdateInitial(
        user: user,
        userTypes: _typesResponse
      ));
    }, (right) async {
      emit(UserUpdateSuccess(
        user: right.data.first
      ));
    });     
  }
}
