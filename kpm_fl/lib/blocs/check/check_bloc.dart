// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kpm_fl/data/data.dart';
import 'package:kpm_fl/models/models.dart';

part 'check_event.dart';
part 'check_state.dart';

class CheckBloc extends Bloc<CheckEvent, CheckState> {
  final DataManager dataManager;
  final String barcode;

  CheckBloc({
    required this.dataManager,
    required this.barcode
  }) : super(CheckInitial()) {
    on<CheckEvent>(_onEvent);
  }

  void _onEvent(
    CheckEvent event,
    Emitter<CheckState> emit
  ) {
    if (event is CheckInit) return _onCheckInit(event, emit);
  }

  void _onCheckInit(
    CheckInit event,
    Emitter<CheckState> emit
  ) async {
    emit(CheckLoading());

    try {
      final response = await dataManager.searchBasket(
        barcode: barcode
      );
      if ((response.errorCode ?? 0) == 0) {
        final check = <String>[];
        response.check?.checkHeader?.checkLine?.forEach((item) {
          if (item.evalue != null) {
            check.add(item.evalue!); 
          }
        });
        // TODO: with kotlin method repeat()
        // like this: '-'.repeat(12)
        check.add('------------');
        response.check?.checkFooter?.checkLine?.forEach((item) {
          if (item.evalue != null) {
            check.add(item.evalue!); 
          }
        });
        emit(CheckShow(
          check: check.join('\n')
        ));
      } else {
        emit(CheckErrorKomplat(
          request: RequestType.searchBasket,
          errorCode: response.errorCode,
          errorText: response.errorText,
        ));
      }
    // ignore: avoid_catches_without_on_clauses
    } catch(e, _) {
      emit(CheckError(
        error: e,
      ));
    }
  }
}
