import 'dart:async';


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';
import 'package:web_cabinet_nkfo/models/models.dart';


part 'audit_archive_event.dart';
part 'audit_archive_state.dart';

class AuditArchiveBloc extends Bloc<AuditArchiveEvent, AuditArchiveState> {
  DataManager dataManager;

  AuditArchiveBloc() : dataManager = InjectionComponent.getDependency<DataManager>(),
  super(AuditArchiveInitLoading());

  List<AuditApplication> _applications = [];
  bool _archiveIsAvaliableAudit = true;
  

  @override
  Stream<AuditArchiveState> mapEventToState(
    AuditArchiveEvent event,
  ) async* {
    if (event is AuditArchiveInit) {
      yield* _mapAuditArchiveInitToState(event);
    } else if (event is AuditArchiveRun) {
      yield* _mapAuditArchiveRunToState(event);
    } 
  }

  Stream<AuditArchiveState> _mapAuditArchiveInitToState(
    AuditArchiveInit event
  ) async* {

    _archiveIsAvaliableAudit = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.auditArchive);

    yield AuditArchiveInitLoading();

    try {
      final applicationsResponse = await dataManager.getAuditApplicationsRequest();
      _applications = applicationsResponse;
      
      yield AuditArchiveLoaded(
        applications: _applications,
      );
    
    } on Exception catch  (error, _){
      yield AuditArchiveInitError(
        error: error
      );
    }
  }

  Stream<AuditArchiveState> _mapAuditArchiveRunToState(
    AuditArchiveRun event
  ) async* {
    yield AuditArchiveLoading();

    try {
      final response = _archiveIsAvaliableAudit? await dataManager.auditArchiveRequest(
        actions: event.application, 
        dateFrom: event.dateFrom
      ) : '';

      yield _archiveIsAvaliableAudit? AuditArchiveSuccess(
        response: response
      ) : const AuditArchiveError(error: AppConfig.archiveIsNotAvaliable);
    
    } on Exception catch  (error, _){
      yield AuditArchiveError(
        error: error
      );
    }
  }
}
