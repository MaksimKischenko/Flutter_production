import 'package:bloc/bloc.dart';
import 'package:helppay_core/data/data.dart';
import 'package:meta/meta.dart';

part 'mdom_delete_event.dart';
part 'mdom_delete_state.dart';

class MdomDeleteBloc extends Bloc<MdomDeleteEvent, MdomDeleteUserState> {
  final DataManager dataManager;

  MdomDeleteBloc({
    required this.dataManager,
  }) : super(MdomDeleteUserInitial()) {
    on<MdomDeleteEvent>(_onEvent);
  }

  void _onEvent(MdomDeleteEvent event, Emitter<MdomDeleteUserState> emit) {
    if (event is MdomDeleteAccount) return _onDeleteAccountInit(event, emit);
    // if (event is PaymentsHistoryLoad) return _onPaymentsHistoryLoad(event, emit);
    // if (event is PaymentsHistoryLoadMore) return _onPaymentsHistoryLoadMore(event, emit);
  }

  // ignore: avoid_void_async
  void _onDeleteAccountInit(
    MdomDeleteAccount event,
    Emitter<MdomDeleteUserState> emit,
  ) async {
    try {
      final response = await dataManager.deleteUserRequest(
        login: event.login,
        userId: event.userId,
      ); //mock data
      if (response.errorCode.evalue == 0) {
        emit(MdomDeleteUserSuccess());
      } else {
        emit(
          MdomDeleteUserErrorKomplat(
            errorCode: response.errorCode.evalue,
            errorMessage: response.errorCode.errorText,
          ),
        );
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (error, _) {
      emit(MdomDeleteUserError(error: error));
    }
  }
}
