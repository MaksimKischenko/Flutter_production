import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:isc_web_app/data/data_manager.dart';
import 'package:meta/meta.dart';

part 'register_payment_claim_event.dart';
part 'register_payment_claim_state.dart';

class RegisterPaymentClaimBloc extends Bloc<RegisterPaymentClaimEvent, RegisterPaymentClaimState> {
  final DataManager dataManager;

  RegisterPaymentClaimBloc({
    required this.dataManager,
  }) : super(RegisterPaymentClaimInitial()) {
    on<RegisterPaymentClaimEvent>(_onEvent);
  }

  void _onEvent(
    RegisterPaymentClaimEvent event,
    Emitter<RegisterPaymentClaimState> emit,
  ) {
    if (event is RegisterPaymentClaimRun) return _onRegisterPaymentClaimRun(event, emit);
  }

  void _onRegisterPaymentClaimRun(
    RegisterPaymentClaimRun event,
    Emitter<RegisterPaymentClaimState> emit,
  ) async {
    emit(RegisterPaymentClaimLoading());
      try {
        final response = await dataManager.registerPaymentOfClaimRequest(
          claimId: event.claimId,
          memDate: event.memDate,
          memNumber: event.memNumber,
          paySum: event.paySum,
          account: event.account
        );
        if (response.errorCode == 0) {    

          emit(RegisterPaymentClaimSuccess(
            paymentId: response.paymentId ?? 0
          ));
        } else {
          emit(RegisterPaymentClaimErrorKomplat(
            errorCode: response.errorCode,
            errorMessage: response.errorText
          ));
        }
      } catch (error, _) {
        emit(RegisterPaymentClaimError(
          error: error
        ));
      }
  }
}