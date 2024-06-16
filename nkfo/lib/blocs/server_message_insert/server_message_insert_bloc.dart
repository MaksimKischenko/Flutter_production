import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';
import 'package:web_cabinet_nkfo/models/models.dart';

part 'server_message_insert_event.dart';
part 'server_message_insert_state.dart';

class ServerMessageInsertBloc extends Bloc<ServerMessageInsertEvent, ServerMessageInsertState> {
  DataManager dataManager;
  
  ServerMessageInsertBloc() : dataManager = InjectionComponent.getDependency<DataManager>(),
  super(ServerMessageInsertInitLoading());

  bool _postIsAvaliable = true;

  @override
  Stream<ServerMessageInsertState> mapEventToState(
    ServerMessageInsertEvent event,
  ) async* {
    if (event is ServerMessageInsertInit) {
      yield* _mapServerMessageInsertInitToState(event);
    } else if (event is ServerMessageInsertRun) {
      yield* _mapServerMessageInsertRunToState(event);
    }
  }

  Stream<ServerMessageInsertState> _mapServerMessageInsertInitToState(
    ServerMessageInsertInit event
  ) async* {

    _postIsAvaliable = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.serverMessage);

    yield ServerMessageInsertInitLoading();

    try {
      final suppliersResponse = await dataManager.getSuppliersRequest(
        select: 'supplier_id,supplier_name,supplier_unp',
      );
      
      yield ServerMessageInsertInitial(
        suppliers: suppliersResponse
      );
    
    } on Exception catch  (error, _){
      yield ServerMessageInsertInitError(
        error: error
      );
    }
  }

  Stream<ServerMessageInsertState> _mapServerMessageInsertRunToState(
    ServerMessageInsertRun event
  ) async* {
    yield ServerMessageInsertLoading();

    try {
      final response = _postIsAvaliable? await dataManager.serverMessageInsertRequest(event.message.copyWith(
        messageDate: DateTime.now(), 
      )): null;
        //request: event.message
      
      yield _postIsAvaliable? ServerMessageInsertSuccess(
        message: response
      ) : const ServerMessageInsertError(
        error: AppConfig.postIsNotAvaliableServerMessage
      );
    
    } on Exception catch  (error, _){
      yield ServerMessageInsertError(
        error: error
      );
    }
  }
}
