import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';
import 'package:web_cabinet_nkfo/models/models.dart';

part 'service_update_event.dart';
part 'service_update_state.dart';

class ServiceUpdateBloc extends Bloc<ServiceUpdateEvent, ServiceUpdateState> {
  DataManager dataManager;

  final int id;
  SupplierAccount? service;
  bool _patchIsAvaliableService = true;

  ServiceUpdateBloc({
    required this.id,
    required this.service
  }) : dataManager = InjectionComponent.getDependency<DataManager>(),
  super(ServiceUpdateInitLoading());

  @override
  Stream<ServiceUpdateState> mapEventToState(
    ServiceUpdateEvent event,
  ) async* {
    if (event is ServiceUpdateInit) {
      yield* _mapServiceUpdateInitToState(event);
    } else if (event is ServiceUpdateRun) {
      yield* _mapServiceUpdateRunToState(event);
    }
  }

  Stream<ServiceUpdateState> _mapServiceUpdateInitToState(
    ServiceUpdateInit event
  ) async* {

    _patchIsAvaliableService = dataManager.userRights.isAvailable(EntityMethod.patchM, EntityName.supplierAccount);

    yield ServiceUpdateInitLoading();

    try {      
      if (service == null) {
        final serviceResponse = await dataManager.supplierAccountRequest(
          id: id
        );
        if (serviceResponse.isEmpty) throw Exception('Service not found');

        service = serviceResponse.first;
      }

      final banksResponse = await dataManager.getBanksRequest();
      final scenariosResponse = await dataManager.getServiceScenarioRequest();
      
      yield ServiceUpdateInitial(
        service: service!,
        banks: banksResponse,
        scenarios: scenariosResponse,
      );
    
    } on Exception catch  (error, _){
      yield ServiceUpdateInitError(
        error: error
      );
    }
  }

  Stream<ServiceUpdateState> _mapServiceUpdateRunToState(
    ServiceUpdateRun event
  ) async* {
    yield ServiceUpdateLoading();

    try {
      final response = _patchIsAvaliableService? await dataManager.supplierAccountUpdateRequest(
        id: id,
        request: event.service
      ) : null;

      yield _patchIsAvaliableService? ServiceUpdateSuccess(
        service: response
      ) : const ServiceUpdateError(
        error: AppConfig.patchIsNotAvaliableSupplierAccount
      );
    
    } on Exception catch  (error, _){
      yield ServiceUpdateError(
        error: error
      );
    }
  }
}
