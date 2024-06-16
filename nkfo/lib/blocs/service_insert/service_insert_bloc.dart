import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';
import 'package:web_cabinet_nkfo/models/models.dart';

part 'service_insert_event.dart';
part 'service_insert_state.dart';

class ServiceInsertBloc extends Bloc<ServiceInsertEvent, ServiceInsertState> {
  DataManager dataManager;

  final int supplierId;
  bool _postIsAvaliableService = true;

  ServiceInsertBloc({
    required this.supplierId
  }) : dataManager = InjectionComponent.getDependency<DataManager>(),
  super(ServiceInsertInitLoading());

  @override
  Stream<ServiceInsertState> mapEventToState(
    ServiceInsertEvent event,
  ) async* {
    if (event is ServiceInsertInit) {
      yield* _mapServiceInsertInitToState(event);
    } else if (event is ServiceInsertRun) {
      yield* _mapServiceInsertRunToState(event);
    }
  }

  Stream<ServiceInsertState> _mapServiceInsertInitToState(
    ServiceInsertInit event
  ) async* {

    _postIsAvaliableService = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.supplierAccount);
    yield ServiceInsertInitLoading();

    try {
      final banksResponse = await dataManager.getBanksRequest();

      final scenariosResponse = await dataManager.getServiceScenarioRequest();
      
      yield ServiceInsertInitial(
        banks: banksResponse,
        scenarios: scenariosResponse
      );
    
    } on Exception catch  (error, _){
      yield ServiceInsertInitError(
        error: error
      );
    }
  }

  Stream<ServiceInsertState> _mapServiceInsertRunToState(
    ServiceInsertRun event
  ) async* {
    yield ServiceInsertLoading();

    try {
      final response = _postIsAvaliableService? await dataManager.supplierAccountInsertRequest(
        request: event.account.copyWith(
          supplierId: supplierId,
        )
      ): null;

      // if (response == null) throw Exception('Account not inserted'); 
      
      yield _postIsAvaliableService? ServiceInsertSuccess(
        account: response
      ) : const ServiceInsertError(
        error: AppConfig.postIsNotAvaliableSupplierAccount
      );
    
    } on Exception catch  (error, _){
      yield ServiceInsertError(
        error: error
      );
    }
  }
}
