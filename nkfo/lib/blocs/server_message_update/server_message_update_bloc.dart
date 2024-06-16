import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';
import 'package:web_cabinet_nkfo/models/models.dart';

part 'server_message_update_event.dart';
part 'server_message_update_state.dart';

class ServerMessageUpdateBloc extends Bloc<ServerMessageUpdateEvent, ServerMessageUpdateState> {
  DataManager dataManager;

  final int id;
  ServerMessage? message;
  bool _patchIsAvaliable = true;

  ServerMessageUpdateBloc({
    required this.id,
    required this.message,
  }) : dataManager = InjectionComponent.getDependency<DataManager>(),
  super(ServerMessageUpdateInitLoading());

  @override
  Stream<ServerMessageUpdateState> mapEventToState(
    ServerMessageUpdateEvent event,
  ) async* {
    if (event is ServerMessageUpdateInit) {
      yield* _mapServerMessageUpdateInitToState(event);
    } else if (event is ServerMessageUpdateRun) {
      yield* _mapServerMessageUpdateRunToState(event);
    } 
  }

  Stream<ServerMessageUpdateState> _mapServerMessageUpdateInitToState(
    ServerMessageUpdateInit event
  ) async* {

    _patchIsAvaliable = dataManager.userRights.isAvailable(EntityMethod.patchM, EntityName.serverMessage);
    yield ServerMessageUpdateInitLoading();

    try {
      if (message == null) {
        final messageResponse = await dataManager.getSupplierServerMessagesRequest(
          id: id
        );
        if(messageResponse.isEmpty) throw Exception('Server message not found');

        message = messageResponse.first;
      }

      final suppliersResponse = await dataManager.getSuppliersRequest(
        select: 'supplier_id,supplier_name,supplier_unp',
      );

      yield ServerMessageUpdateInitial(
        message: message!,
        suppliers: suppliersResponse
      );
    
    } on Exception catch  (error, _){
      yield ServerMessageUpdateInitError(
        error: error
      );
    }
  }


  Stream<ServerMessageUpdateState> _mapServerMessageUpdateRunToState(
    ServerMessageUpdateRun event
  ) async* {
    yield ServerMessageUpdateLoading();

    try {
      final response = _patchIsAvaliable? await dataManager.serverMessageUpdateRequest(
        id: id, 
        request: event.message
      ) : null;

      // if (response == null) throw Exception('Message not inserted'); 

      yield _patchIsAvaliable? ServerMessageUpdateSuccess(
        message: response
      ) : const ServerMessageUpdateError(
        error: AppConfig.patchIsNotAvaliableServerMessage
      );
    
    } on Exception catch  (error, _){
      yield ServerMessageUpdateError(
        error: error
      );
    }
  }
}
