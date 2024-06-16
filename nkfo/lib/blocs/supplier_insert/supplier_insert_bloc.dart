import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';
import 'package:web_cabinet_nkfo/models/models.dart';

part 'supplier_insert_event.dart';
part 'supplier_insert_state.dart';

class SupplierInsertBloc extends Bloc<SupplierInsertEvent, SupplierInsertState> {
  DataManager dataManager;
  
  SupplierInsertBloc() : dataManager = InjectionComponent.getDependency<DataManager>(),
  super(SupplierInsertInitLoading());

  bool _postIsAvaliable = true;

  @override
  Stream<SupplierInsertState> mapEventToState(
    SupplierInsertEvent event,
  ) async* {
    if (event is SupplierInsertInit) {
      yield* _mapSupplierInsertInitToState(event);
    } else if (event is SupplierInsertRun) {
      yield* _mapSupplierInsertRunToState(event);
    }
  }

  Stream<SupplierInsertState> _mapSupplierInsertInitToState(
    SupplierInsertInit event
  ) async* {

    _postIsAvaliable = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.supplier);

    yield SupplierInsertInitLoading();

    try {
      final response = await dataManager.getBanksRequest();
      
      yield SupplierInsertInitial(
        banks: response,
      );
    
    } on Exception catch  (error, _){
      yield SupplierInsertInitError(
        error: error
      );
    }
  }

  Stream<SupplierInsertState> _mapSupplierInsertRunToState(
    SupplierInsertRun event
  ) async* {
    yield SupplierInsertLoading();

    try {

      final response = _postIsAvaliable? await dataManager.supplierInsertRequest(event.supplier) : null;

      yield _postIsAvaliable? SupplierInsertSuccess(
        supplier: response
      ) : const SupplierInsertError(
        error: AppConfig.postIsNotAvaliableSupplier
      );
    
    } on Exception catch  (error, _){
      yield SupplierInsertError(
        error: error
      );
    }
  }
}
