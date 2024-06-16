// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/models/models.dart';
import 'package:helppay_payform_app/utils/loger.dart';

part 'check_event.dart';
part 'check_state.dart';

void _log(dynamic message) => Logger.helpPayLog(message, name: 'check_bloc');

class CheckBloc extends Bloc<CheckEvent, CheckState> {
  final DataManager dataManager;
  final int paymentId;
  final List<String> initialCheckList;
  final int code;
  final String name;

  CheckBloc(this.dataManager,
      {required this.paymentId,
      required this.initialCheckList,
      required this.code,
      required this.name})
      : super(CheckLoading()) {
    on<CheckEvent>(_onEvent);
  }

  void _onEvent(CheckEvent event, Emitter<CheckState> emit) {
    if (event is CheckInit) {
      return _onCheckInit(event, emit);
    }
  }

  void _onCheckInit(CheckInit event, Emitter<CheckState> emit) async {
    emit(CheckLoading());

    if (initialCheckList.isEmpty) {
      try {
        final response =
            await dataManager.getCheckDuplicateRequest(paymentId: paymentId);
        if ((response.errorCode ?? 0) == 0) {
          final checkList = <String>[];

          final checkHeader = response.check?.checkHeader?.checkLine
              ?.map((e) => e.evalue)
              .toList();
          final checkFooter = response.check?.checkFooter?.checkLine
              ?.map((e) => e.evalue)
              .toList();

          checkHeader?.forEach((value) {
            if (value?.isNotEmpty ?? false) checkList.add(value!);
          });
          checkFooter?.forEach((value) {
            if (value?.isNotEmpty ?? false) checkList.add(value!);
          });

          emit(CheckInitial(
              paymentId: paymentId, check: checkList, code: code, name: name));
        } else {
          emit(CheckErrorKomplat(
              request: RequestType.checkDuplicate,
              errorCode: response.errorCode,
              errorText: response.errorText));
        }
      } on Exception catch (error, _) {
        emit(CheckError(error: error));
      }
    } else {
      emit(CheckInitial(
          paymentId: paymentId,
          check: initialCheckList,
          code: code,
          name: name));
    }
  }
}
