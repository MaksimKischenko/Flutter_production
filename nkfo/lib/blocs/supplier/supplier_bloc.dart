import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';
import 'package:web_cabinet_nkfo/models/models.dart';

part 'supplier_event.dart';
part 'supplier_state.dart';

class SupplierBloc extends Bloc<SupplierEvent, SupplierState> {
  DataManager dataManager;

  final int id;
  Supplier? supplier;
  List<SupplierAccount> services = [];
  bool _patchIsAvaliableSupplier = true;
  bool _deleteIsAvaliableSupplier = true;
  bool _getIsAvailableServices = true;
  bool _postIsAvaliableService= true;
  bool _patchIsAvaliableService= true;
  bool _deleteIsAvaliableService = true;

  SupplierBloc({
    required this.id,
    required this.supplier
  }) : dataManager = InjectionComponent.getDependency<DataManager>(),
  super(SupplierLoading());

  @override
  Stream<SupplierState> mapEventToState(
    SupplierEvent event,
  ) async* {
    if (event is SupplierInit) {
      yield* _mapSupplierInitToState(event);
    } else if (event is SupplierUpdate) {
      yield* _mapSupplierUpdateToState(event);
    } else if (event is SupplierDelete) {
      yield* _mapSupplierDeleteToState(event);
    } else if (event is SupplierNewService) {
      yield* _mapSupplierNewServiceToState(event);
    } else if (event is SupplierDeleteService) {
      yield* _mapSupplierDeleteServiceToState(event);
    } else if (event is SupplierUpdateService) {
      yield* _mapSupplierUpdateServiceToState(event);
    }
  }

  Stream<SupplierState> _mapSupplierInitToState(
    SupplierInit event
  ) async* {
    yield SupplierLoading();

    _patchIsAvaliableSupplier = dataManager.userRights.isAvailable(EntityMethod.patchM, EntityName.supplier);
    _deleteIsAvaliableSupplier = dataManager.userRights.isAvailable(EntityMethod.deleteM, EntityName.supplier);
    _getIsAvailableServices = dataManager.userRights.isAvailable(EntityMethod.getM, EntityName.supplierAccount);
    _postIsAvaliableService = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.supplierAccount);
    _patchIsAvaliableService = dataManager.userRights.isAvailable(EntityMethod.patchM, EntityName.supplierAccount);
    _deleteIsAvaliableService = dataManager.userRights.isAvailable(EntityMethod.deleteM, EntityName.supplierAccount);

    try {
      if (supplier == null) {
        final suppliersResponse = await dataManager.getSuppliersRequest(
          id: id
        );
        if (suppliersResponse.isEmpty) throw Exception('Supplier not found');
        supplier = suppliersResponse.first;
      }

      final servicesResponse = _getIsAvailableServices? await dataManager.supplierAccountRequest(
        supplierId: id
      ): <SupplierAccount>[];

      services = servicesResponse;

      yield SupplierInitial(
        supplier: supplier!,
        services: services,
        patchIsAvaiableSupplier: _patchIsAvaliableSupplier,
        deleteIsAvaliableSupplier: _deleteIsAvaliableSupplier,
        getIsAvailableService: _getIsAvailableServices,
        postIsAvaliableService: _postIsAvaliableService,
        patchIsAvaliableService: _patchIsAvaliableService,
        deleteIsAvaliableService: _deleteIsAvaliableService
      );
    
    } on Exception catch  (error, _){
      yield SupplierInitError(
        error: error
      );
    }
  }

  Stream<SupplierState> _mapSupplierUpdateToState(
    SupplierUpdate event
  ) async* {
    yield SupplierLoading();

    supplier = event.supplier;

    //For updating services in screen 
    final services = await dataManager.supplierAccountRequest(
      supplierId: id
    );

    // if(supplier?.enabled == false) {
    //   for (var i = 0; i < services.length; i++) {
    //     services[i] = services[i].copyWith(enabled: false, dateEnd: DateTime.now());
    //   }
    // }

    yield SupplierInitial(
      supplier: supplier!,
      services: services,
      patchIsAvaiableSupplier: _patchIsAvaliableSupplier,
      deleteIsAvaliableSupplier: _deleteIsAvaliableSupplier,
      getIsAvailableService: _getIsAvailableServices,
      postIsAvaliableService: _postIsAvaliableService,
      patchIsAvaliableService: _patchIsAvaliableService,
      deleteIsAvaliableService: _deleteIsAvaliableService      
    );
  }

  Stream<SupplierState> _mapSupplierDeleteToState(
    SupplierDelete event
  ) async* {
    yield SupplierLoading();

    try {
      final response = _deleteIsAvaliableSupplier? await dataManager.supplierDeleteRequest(
        id: id
      ) : null;

      yield _deleteIsAvaliableSupplier? SupplierDeleteSuccess(supplier: response) 
      : const SupplierError(error: AppConfig.deleteIsNotAvaliableSupplier);
    
    } on Exception catch  (error, _){
      yield SupplierError(
        error: error
      );
      yield SupplierInitial(
        supplier: supplier!,
        services: services,
        patchIsAvaiableSupplier: _patchIsAvaliableSupplier,
        deleteIsAvaliableSupplier: _deleteIsAvaliableSupplier,
        getIsAvailableService: _getIsAvailableServices,
        postIsAvaliableService: _postIsAvaliableService,
        patchIsAvaliableService: _patchIsAvaliableService,
        deleteIsAvaliableService: _deleteIsAvaliableService        
      );
    }
  }

  Stream<SupplierState> _mapSupplierNewServiceToState(
    SupplierNewService event
  ) async* {
    yield SupplierLoading();

    services.add(event.service);

    yield SupplierInitial(
      supplier: supplier!,
      services: services,
      patchIsAvaiableSupplier: _patchIsAvaliableSupplier,
      deleteIsAvaliableSupplier: _deleteIsAvaliableSupplier,
      getIsAvailableService: _getIsAvailableServices,
      postIsAvaliableService: _postIsAvaliableService,
      patchIsAvaliableService: _patchIsAvaliableService,
      deleteIsAvaliableService: _deleteIsAvaliableService      
    );
  }

  Stream<SupplierState> _mapSupplierDeleteServiceToState(
    SupplierDeleteService event
  ) async* {
    yield SupplierLoading();

    try {
      final response = await dataManager.supplierAccountDeleteRequest(
        id: event.id
      );


      services.removeWhere((e) => e.id == event.id);

      yield SupplierServiceDeleteSuccess(service: response);

      yield SupplierInitial(
        supplier: supplier!,
        services: services,
        patchIsAvaiableSupplier: _patchIsAvaliableSupplier,
        deleteIsAvaliableSupplier: _deleteIsAvaliableSupplier,
        getIsAvailableService: _getIsAvailableServices,
        postIsAvaliableService: _postIsAvaliableService,
        patchIsAvaliableService: _patchIsAvaliableService,
        deleteIsAvaliableService: _deleteIsAvaliableService        
      );
    
    } on Exception catch  (error, _){
      yield SupplierError(
        error: error
      );
      yield SupplierInitial(
        supplier: supplier!,
        services: services,
        patchIsAvaiableSupplier: _patchIsAvaliableSupplier,
        deleteIsAvaliableSupplier: _deleteIsAvaliableSupplier,
        getIsAvailableService: _getIsAvailableServices,
        postIsAvaliableService: _postIsAvaliableService,
        patchIsAvaliableService: _patchIsAvaliableService,
        deleteIsAvaliableService: _deleteIsAvaliableService        
      );
    }
  }

  Stream<SupplierState> _mapSupplierUpdateServiceToState(
    SupplierUpdateService event
  ) async* {
    yield SupplierLoading();

    final index = services.indexWhere((e) => e.id == event.service.id);
    if (index > -1) {
      services[index] = event.service;
    }

    yield SupplierInitial(
      supplier: supplier!,
      services: services,
      patchIsAvaiableSupplier: _patchIsAvaliableSupplier,
      deleteIsAvaliableSupplier: _deleteIsAvaliableSupplier,
      getIsAvailableService: _getIsAvailableServices,
      postIsAvaliableService: _postIsAvaliableService,
      patchIsAvaliableService: _patchIsAvaliableService,
      deleteIsAvaliableService: _deleteIsAvaliableService      
    );
  }
}
