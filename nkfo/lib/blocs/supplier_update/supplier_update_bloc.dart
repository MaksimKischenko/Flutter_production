import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';
import 'package:web_cabinet_nkfo/models/models.dart';

part 'supplier_update_event.dart';
part 'supplier_update_state.dart';

class SupplierUpdateBloc extends Bloc<SupplierUpdateEvent, SupplierUpdateState> {
  DataManager dataManager;

  final int id;
  Supplier? supplier;
  bool _patchIsAvaliable = true;

  SupplierUpdateBloc({
    required this.id,
    required this.supplier
  }) : dataManager = InjectionComponent.getDependency<DataManager>(),
  super(SupplierUpdateInitLoading());

  @override
  Stream<SupplierUpdateState> mapEventToState(
    SupplierUpdateEvent event,
  ) async* {
    if (event is SupplierUpdateInit) {
      yield* _mapSupplierUpdateInitToState(event);
    } else if (event is SupplierUpdateRun) {
      yield* _mapSupplierUpdateRunToState(event);
    }
  }

  Stream<SupplierUpdateState> _mapSupplierUpdateInitToState(
    SupplierUpdateInit event
  ) async* {

    _patchIsAvaliable = dataManager.userRights.isAvailable(EntityMethod.patchM, EntityName.supplier);

    yield SupplierUpdateInitLoading();

    try {
      if (supplier == null) {
        final suppliersResponse = await dataManager.getSuppliersRequest(
          id: id
        );
     
        supplier = suppliersResponse.first;
      }

      final banksResponse = await dataManager.getBanksRequest();
      
      yield SupplierUpdateInitial(
        banks: banksResponse,
        supplier: supplier
      );
    
    } on Exception catch  (error, _){
      yield SupplierUpdateInitError(
        error: error
      );
    }
  }

  Stream<SupplierUpdateState> _mapSupplierUpdateRunToState(
    SupplierUpdateRun event
  ) async* {
    yield SupplierUpdateLoading();

    try {
      final response = _patchIsAvaliable? await dataManager.supplierUpdateRequest(
        id: id,
        request: event.supplier
      ) : null;

      yield _patchIsAvaliable? SupplierUpdateSuccess(
        supplier: response
      ) : const SupplierUpdateError(
        error: AppConfig.patchIsNotAvaliableSupplier
      );
    
    } on Exception catch  (error, _){
      yield SupplierUpdateError(
        error: error
      );
    }
  }
}
