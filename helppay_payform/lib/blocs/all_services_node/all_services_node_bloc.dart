// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/models/models.dart';

part 'all_services_node_event.dart';
part 'all_services_node_state.dart';

class AllServicesNodeBloc extends Bloc<AllServicesNodeEvent, AllServicesNodeState> {
  final DataManager dataManager;
  final int payCode;
  final int diType;
  
  AllServicesNodeBloc({
    required this.dataManager,
    required this.payCode,
    required this.diType
  }) : super(AllServicesNodeInitial()) {
    on<AllServicesNodeEvent>(_onEvent);
  }

  void _onEvent(
    AllServicesNodeEvent event,
    Emitter<AllServicesNodeState> emit
  ) {
    if (event is AllServicesNodeInit) return _onAllServicesNodeInit(event, emit);
  }

  void _onAllServicesNodeInit(
    AllServicesNodeInit event,
    Emitter<AllServicesNodeState> emit
  ) async {
    emit(AllServicesNodeLoading());

    try {
      final response = await dataManager.getPayListRequest(
        payCode: payCode,
        diType: diType
      );
      if ((response.errorCode ?? 0) == 0) {
        emit(AllServicesNodeLoaded(
          services: response.payRecord?.map((e) => EripService.fromPayRecord(e)).toList() ?? []
        ));
      } else {
        emit(AllServicesNodeErrorKomplat(
          request: RequestType.getPayList,
          errorCode: response.errorCode,
          errorText: response.errorText
        ));
      }
    // ignore: avoid_catches_without_on_clauses
    } catch(error, _) {
      emit(AllServicesNodeError(
        error: error
      ));
    }
  }
}
