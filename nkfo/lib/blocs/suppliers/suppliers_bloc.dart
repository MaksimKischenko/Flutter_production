import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';
import 'package:web_cabinet_nkfo/models/models.dart';

part 'suppliers_event.dart';
part 'suppliers_state.dart';

class SuppliersBloc extends Bloc<SuppliersEvent, SuppliersState> {
  DataManager dataManager;

  SuppliersBloc() : dataManager = InjectionComponent.getDependency<DataManager>(), super(SuppliersLoading());

  SupplierStatus _status = SupplierStatus.all;
  String? _unp;
  String? _shortName;
  SuppliersSort _sort = AppConfig.suppliersDefaultSort;
  bool _sortAscending = AppConfig.suppliersDefaultSortAscending;
  bool _isLoadMoreAvaiable = true;

  List<Supplier> _organizations = [];
  bool _getIsAvaliable = true;
  bool _postIsAvaliable = true;

  @override
  Stream<SuppliersState> mapEventToState(
    SuppliersEvent event,
  ) async* {
    if (event is SuppliersInit) {
      yield* _mapSuppliersInitToState(event);
    } else if (event is SuppliersLoadMore) {
      yield* _mapSuppliersLoadMoreToState(event);
    } else if (event is SuppliersUpdateSupplier) {
      yield* _mapSuppliersUpdateSupplierToState(event);
    } else if (event is SuppliersDeleteSupplier) {
      yield* _mapSuppliersDeleteSupplierToState(event);
    } else if (event is SuppliersNewSupplier) {
      yield* _mapSuppliersNewSupplierToState(event); 
    }
  }

  Stream<SuppliersState> _mapSuppliersInitToState(
    SuppliersInit event
  ) async* {

    _getIsAvaliable =  dataManager.userRights.isAvailable(EntityMethod.getM, EntityName.supplier);
    _postIsAvaliable = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.supplier);

    yield SuppliersLoading();

    try {
      final status = event.status ?? SupplierStatus.all;

      final response = _getIsAvaliable? await dataManager.getSuppliersRequest(
        count: event.loadCount,
        status: status,
        unp: event.unp,
        shortName: event.shortName,
        sort: event.sort ?? _sort,
        sortAscending: event.sortAscending ?? _sortAscending,
      ) : <Supplier>[];

      _status = status;
      _unp = event.unp;
      _shortName = event.shortName;
      if (event.sort != null) _sort = event.sort!;
      if (event.sortAscending != null) _sortAscending = event.sortAscending!;

      _organizations = response;
      _isLoadMoreAvaiable = !(response.length < AppConfig.suppliersGetLoadCount);
      
      yield _getIsAvaliable? SuppliersLoaded(
        suppliers: _organizations,
        sort: _sort,
        sortAscending: _sortAscending,
        isLoadMoreAvaiable: _isLoadMoreAvaiable,
        postIsAvaliable: _postIsAvaliable
      ) : const SuppliersGetNotAllow(
        message: AppConfig.getIsNotAvaliableSupplier
      );
    
    } on Exception catch  (error, _){
      yield SuppliersError(
        error: error
      );
    }
  }

  Stream<SuppliersState> _mapSuppliersLoadMoreToState(
    SuppliersLoadMore event
  ) async* {
    yield SuppliersLoading();
    
    try {
      final response = await dataManager.getSuppliersRequest(
        count: AppConfig.suppliersGetLoadCount,
        status: _status,
        unp: _unp,
        shortName: _shortName,
        offset: event.offset,
        sort: _sort,
        sortAscending: _sortAscending,
      );

      _organizations.addAll(response);
      _isLoadMoreAvaiable = !(response.length < AppConfig.suppliersGetLoadCount);
      
      yield SuppliersLoaded(
        suppliers: _organizations,
        sort: _sort,
        sortAscending: _sortAscending,
        isLoadMoreAvaiable: _isLoadMoreAvaiable
      );
    
    } on Exception catch  (error, _){
      yield SuppliersError(
        error: error
      );
    }
  }

  Stream<SuppliersState> _mapSuppliersUpdateSupplierToState(
    SuppliersUpdateSupplier event
  ) async* {
    yield SuppliersLoading();

    final index = _organizations.indexWhere((e) => e.id == event.supplier?.id);
    if (index > -1) {
      _organizations[index] = event.supplier ?? const Supplier(id: -1);
    }

    yield SuppliersLoaded(
      suppliers: _organizations,
      sort: _sort,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable: _isLoadMoreAvaiable,
      postIsAvaliable: _postIsAvaliable
    );
  }

  Stream<SuppliersState> _mapSuppliersDeleteSupplierToState(
    SuppliersDeleteSupplier event
  ) async* {
    yield SuppliersLoading();

    final index = _organizations.indexWhere((e) => e.id == event.supplier?.id);
    if (index > -1) {
      _organizations.removeAt(index);
    }

    yield SuppliersLoaded(
      suppliers: _organizations,
      sort: _sort,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable: _isLoadMoreAvaiable,
      postIsAvaliable: _postIsAvaliable
    );
  }

  Stream<SuppliersState> _mapSuppliersNewSupplierToState(
    SuppliersNewSupplier event
  ) async* {
    yield SuppliersLoading();

    _organizations.insert(0, event.supplier);

    yield SuppliersLoaded(
      suppliers: _organizations,
      sort: _sort,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable: _isLoadMoreAvaiable,
      postIsAvaliable: _postIsAvaliable
    );
  }
}
