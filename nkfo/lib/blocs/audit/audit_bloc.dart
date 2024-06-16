import 'dart:async';


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';
import 'package:web_cabinet_nkfo/models/models.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';

part 'audit_event.dart';
part 'audit_state.dart';

class AuditBloc extends Bloc<AuditEvent, AuditState> {
  DataManager dataManager;

  AuditBloc() : dataManager = InjectionComponent.getDependency<DataManager>(),
  super(AuditLoading());

  DateTime? _dateFrom;
  DateTime? _dateTo;
  List<AuditApplication> _applications = [];
  AuditApplication? _application;
  List<AuditAction> _actions = [];
  AuditAction? _action;
  List<Supplier> _suppliers = [];
  int? _supplierId;
  String? _description;

  AuditSort _sort = AppConfig.auditDefaultSort;
  bool _sortAscending = AppConfig.auditDefaultSortAscending;
  bool _isLoadMoreAvaiable = true;

  bool _getIsAvaliableSupplier = true;
  bool _getIsAvaliableAudit = true;
  bool _getIsAvaliableAuditApplication = true;
  bool _getIsAvaliableAuditAction = true;
  bool _archiveIsAvaliableAudit = true;

  List<Audit> _audit = [];

  @override
  Stream<AuditState> mapEventToState(
    AuditEvent event,
  ) async* {
    if (event is AuditInit) {
      yield* _mapAuditInitToState(event);
    } else if (event is AuditLoad) {
      yield* _mapAuditLoadToState(event);
    } else if (event is AuditLoadMore) {
      yield* _mapAuditLoadMoreToState(event);
    } else if (event is AuditExportRun) {
      yield* _mapAuditExportRunToState(event);
    }
  }

  Stream<AuditState> _mapAuditInitToState(
    AuditInit event
  ) async* {

    _getIsAvaliableSupplier =  dataManager.userRights.isAvailable(EntityMethod.getM, EntityName.supplier);
    _getIsAvaliableAudit = dataManager.userRights.isAvailable(EntityMethod.getM, EntityName.audit);
    _getIsAvaliableAuditApplication = dataManager.userRights.isAvailable(EntityMethod.getM, EntityName.auditApplication);
    _getIsAvaliableAuditAction = dataManager.userRights.isAvailable(EntityMethod.getM, EntityName.auditAction);
    _archiveIsAvaliableAudit = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.auditArchive);

    yield AuditInitLoading();

    try {
      final suppliersResponse = _getIsAvaliableSupplier? await dataManager.getSuppliersRequest(
        select: 'supplier_id,supplier_name,supplier_unp'
      ) : null;
      _suppliers = suppliersResponse ?? [];

      final applicationsResponse = _getIsAvaliableAuditApplication? await dataManager.getAuditApplicationsRequest() : null;
      _applications = applicationsResponse ?? [];

      final actionsResponse = _getIsAvaliableAuditAction? await dataManager.getAuditActionRequest() : null;
      _actions = actionsResponse ?? [];
      
      yield AuditLoaded(
        audit: _audit,
        sort: _sort,
        sortAscending: _sortAscending,
        isLoadMoreAvaiable: _isLoadMoreAvaiable,
        dateFrom: _dateFrom,
        dateTo: _dateTo,
        applications: _applications,
        selectedApplication: _application,
        actions: _actions,
        selectedAction: _action,
        suppliers: _suppliers,
        supplierId: _supplierId,
        description: _description,
        getIsAvaliableAuditAction: _getIsAvaliableAuditAction,
        getIsAvaliableAudit: _getIsAvaliableAudit,
        getIsAvaliableAuditApplication: _getIsAvaliableAuditApplication,
        getIsAvaliableSupplier: _getIsAvaliableSupplier,
        archiveIsAvaliableAudit: _archiveIsAvaliableAudit
      );
    
    } on Exception catch  (error, _){
      yield AuditInitError(
        error: error
      );
    }
  }

  Stream<AuditState> _mapAuditLoadToState(
    AuditLoad event
  ) async* {
    yield AuditLoading();

    try {
      final response =  _getIsAvaliableAudit? await dataManager.getAuditRequest(
        count: event.loadCount,
        sort: event.sort ?? AppConfig.auditDefaultSort,
        sortAscending: event.sortAscending ?? AppConfig.usersDefaultSortAscending,
        dateFrom: event.dateFrom,
        dateTo: event.dateTo,
        application: event.application,
        action: event.action,
        supplierId: event.supplierId,
        description: event.description
      ) : <Audit>[];

      _dateFrom = event.dateFrom;
      _dateTo = event.dateTo;
      _application = event.application;
      _action = event.action;
      _supplierId = event.supplierId;
      _description = event.description;
      if (event.sort != null) _sort = event.sort!;
      if (event.sortAscending != null) _sortAscending = event.sortAscending!;

      _audit = response;
      _isLoadMoreAvaiable = !(response.length < AppConfig.auditGetLoadCount);
    
    } on Exception catch  (error, _){
      yield AuditError(
        error: error
      );
    }

    yield _getIsAvaliableAudit? AuditLoaded(
      audit: _audit,
      sort: _sort,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable: _isLoadMoreAvaiable,
      dateFrom: _dateFrom,
      dateTo: _dateTo,
      applications: _applications,
      selectedApplication: _application,
      actions: _actions,
      selectedAction: _action,
      suppliers: _suppliers,
      supplierId: _supplierId,
      description: _description,
      getIsAvaliableAuditAction: _getIsAvaliableAuditAction,
      getIsAvaliableAudit: _getIsAvaliableAudit,
      getIsAvaliableAuditApplication: _getIsAvaliableAuditApplication,
      getIsAvaliableSupplier: _getIsAvaliableSupplier,
      archiveIsAvaliableAudit: _archiveIsAvaliableAudit
    ) : const AuditGetNotAllow(
      message: AppConfig.getIsNotAvaliableAudit
    );
  }

  Stream<AuditState> _mapAuditLoadMoreToState(
    AuditLoadMore event
  ) async* {
    yield AuditLoading();

    try {
      final response = await dataManager.getAuditRequest(
        count: AppConfig.auditGetLoadCount,
        offset: event.offset,
        sort: _sort,
        sortAscending: _sortAscending,
        dateFrom: _dateFrom,
        dateTo: _dateTo,
        application: _application,
        action: _action,
        supplierId: _supplierId,
        description: _description
      );

      _audit.addAll(response);
      _isLoadMoreAvaiable = !(response.length < AppConfig.auditGetLoadCount);
    
    } on Exception catch  (error, _){
      yield AuditError(
        error: error
      );
    }

    yield AuditLoaded(
      audit: _audit,
      sort: _sort,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable: _isLoadMoreAvaiable,
      dateFrom: _dateFrom,
      dateTo: _dateTo,
      applications: _applications,
      selectedApplication: _application,
      actions: _actions,
      selectedAction: _action,
      suppliers: _suppliers,
      supplierId: _supplierId,
      description: _description,
      getIsAvaliableAuditAction: _getIsAvaliableAuditAction,
      getIsAvaliableAudit: _getIsAvaliableAudit,
      getIsAvaliableAuditApplication: _getIsAvaliableAuditApplication,
      getIsAvaliableSupplier: _getIsAvaliableSupplier,
      archiveIsAvaliableAudit: _archiveIsAvaliableAudit      
    );
  }

  Stream<AuditState> _mapAuditExportRunToState(
    AuditExportRun event
  ) async* {
    yield AuditLoading();

    var sheetName = '';
    var response = <Audit>[];

    try {

      await compute((message) async{
        response = _getIsAvaliableAudit? await dataManager.getAuditRequest(
          sort: _sort,
          sortAscending: _sortAscending,
          dateFrom: _dateFrom,
          dateTo: _dateTo,
          application: _application,
          action: _action,
          supplierId: _supplierId,
          description: _description
        ): <Audit>[];
      }, null);


      await compute((message) => sheetName =  createExcel(response), null);

      yield AuditExportSuccess(
        fileName: '$sheetName.xlsx',
        rowCount: response.length
      );
    
    } on Exception catch  (error, _){
      yield AuditError(
        error: error
      );
    }

    yield AuditLoaded(
      audit: _audit,
      sort: _sort,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable: _isLoadMoreAvaiable,
      dateFrom: _dateFrom,
      dateTo: _dateTo,
      applications: _applications,
      selectedApplication: _application,
      actions: _actions,
      selectedAction: _action,
      suppliers: _suppliers,
      supplierId: _supplierId,
      description: _description,
      getIsAvaliableAuditAction: _getIsAvaliableAuditAction,
      getIsAvaliableAudit: _getIsAvaliableAudit,
      getIsAvaliableAuditApplication: _getIsAvaliableAuditApplication,
      getIsAvaliableSupplier: _getIsAvaliableSupplier,
      archiveIsAvaliableAudit: _archiveIsAvaliableAudit
    );
  }
}


String createExcel(List<Audit> response) {
      final excel = Excel.createExcel();
      final sheetName = 'AuditLog.${DateFormat('dd-MM-yyyy').format(DateTime.now())}';
      excel.rename('Sheet1', sheetName);

      final headers = ['Дата и время', 'Тип события', 'Приложение', 'Логин пользователя', 'ФИО пользователя', 'Организация', 'Описание'];
      excel[sheetName].insertRowIterables(headers, 0);

      final headerCellStyle = CellStyle(horizontalAlign: HorizontalAlign.Center, bold: true, underline: Underline.Single, /*textWrapping: TextWrapping.WrapText*/);
      final headerCells = excel[sheetName].selectRange(CellIndex.indexByString('A1'), end: CellIndex.indexByString('G1'));
      headerCells.first?.forEach((cell) {
        cell?.cellStyle = headerCellStyle;
      });

      response.forEachIndexed((e, i) {
        excel[sheetName].insertRowIterables(<dynamic>[e.date?.toStringFormattedGetOperationHistory() ?? '', e.actionName ?? '', e.application, e.clientLogin ?? '', e.clientName ?? '', e.supplierName ?? '', e.description ?? ''], i + 1);
      });

      for (var i = 0; i < 7; i++) {
        excel[sheetName].setColWidth(i, 30);
      }
      
      // idk why, but w/o this it doesn't work
      excel[sheetName].setColWidth(7, 25);

      // if (kIsWeb) {
  
      excel.save(fileName: '$sheetName.xlsx');

      return sheetName;
}