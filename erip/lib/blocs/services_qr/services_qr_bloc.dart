import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bpc_nkfo/data/data.dart';
import 'package:bpc_nkfo/injection_component.dart';
import 'package:bpc_nkfo/utils/utils.dart';
import 'package:dartx/dartx.dart';
import 'package:equatable/equatable.dart';

part 'services_qr_event.dart';
part 'services_qr_state.dart';

class ServicesQrBloc extends Bloc<ServicesQrEvent, ServicesQrState> {
  final DataManager _dataManager;

  ServicesQrBloc() : _dataManager = InjectionComponent.getDependency<DataManager>(), super(ServicesQrLoading());

  late List<Service> availableServices;

  @override
  Stream<ServicesQrState> mapEventToState(
    ServicesQrEvent event,
  ) async* {
    if (event is ServicesQrInit) {
      yield* _mapServicesQrInitToState(event);
    }
    if (event is ServicesQrSelected) {
      yield* _mapServicesQrSelectedToState(event);
    }
  }

  Stream<ServicesQrState> _mapServicesQrInitToState(
    ServicesQrInit event
  ) async* {
    yield ServicesQrLoading();

    availableServices = _dataManager.servicesList;

    if (_dataManager.servicesList.firstOrNull != null) {
      yield ServicesQrInitial(
        selected: availableServices.first,
        available: availableServices,
        qrData: QrErip.generateForService(availableServices.first.code ?? 0)
      );
    } else {
      yield ServicesQrUnavailable();
    }
  }

  Stream<ServicesQrState> _mapServicesQrSelectedToState(
    ServicesQrSelected event
  ) async* {
    yield ServicesQrLoading();

    yield ServicesQrInitial(
      selected: event.service,
      available: availableServices,
      qrData: QrErip.generateForService(event.service.code ?? 0)
    );
  }
}
