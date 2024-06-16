// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/utils/utils.dart';
import 'package:dartx/dartx.dart';
import 'package:equatable/equatable.dart';

part 'services_qr_event.dart';
part 'services_qr_state.dart';

class ServicesQrBloc extends Bloc<ServicesQrEvent, ServicesQrState> {
  final DataManager dataManager;

  ServicesQrBloc({
    required this.dataManager,
  }) : super(ServicesQrLoading()) {
    on<ServicesQrEvent>(_onEvent);
  }

  late List<Service> availableServices;

  void _onEvent(
    ServicesQrEvent event,
    Emitter<ServicesQrState> emit,
  ) {
    if (event is ServicesQrInit) return _onServicesQrInit(event, emit);
    if (event is ServicesQrSelected) return _onServicesQrSelected(event, emit);
  }

  void _onServicesQrInit(
    ServicesQrInit event,
    Emitter<ServicesQrState> emit,
  ) async {
    emit(ServicesQrLoading());

    availableServices = dataManager.servicesList;

    if (dataManager.servicesList.firstOrNull != null) {
      emit(ServicesQrInitial(
        selected: availableServices.first,
        available: availableServices,
        qrData: QrErip.generateForService(availableServices.first.code)
      ));
    } else {
      emit(ServicesQrUnavailable());
    }
  }

  void _onServicesQrSelected(
    ServicesQrSelected event,
    Emitter<ServicesQrState> emit,
  ) async {
    emit(ServicesQrLoading());

    emit(ServicesQrInitial(
      selected: event.service,
      available: availableServices,
      qrData: QrErip.generateForService(event.service.code)
    ));
  }
}
