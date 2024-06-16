import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';

part 'server_message_event.dart';
part 'server_message_state.dart';

class ServerMessageBloc extends Bloc<ServerMessageEvent, ServerMessageState> {
  DataManager dataManager;

  final int id;
  ServerMessage? message;
  List<Supplier> _suppliers = [];

  ServerMessageBloc({
    required this.id,
    required this.message,
  }) : dataManager = InjectionComponent.getDependency<DataManager>(),
  super(ServerMessageInitLoading());

  @override
  Stream<ServerMessageState> mapEventToState(
    ServerMessageEvent event,
  ) async* {
    if (event is ServerMessageInit) {
      yield* _mapServerMessageInitToState(event);
    } else if (event is ServerMessageDelete) {
      yield* _mapServerMessageDeleteToState(event);
    }
  }

  Stream<ServerMessageState> _mapServerMessageInitToState(
      ServerMessageInit event
  ) async* {
    yield ServerMessageInitLoading();

    try {
      if (message == null){
        final messageResponse = await dataManager.getSupplierServerMessagesRequest(
          id: id
        );
        if(messageResponse.isEmpty) throw Exception('Server message not found');
        message = messageResponse.first;
      }

      if (message?.supplierId?.isNotEmpty ?? false) {
        final suppliersResponse = await dataManager.getSuppliersRequest(
          select: 'supplier_id,supplier_name,supplier_unp',
          ids: message?.supplierId
        );
        _suppliers = suppliersResponse;
      }
      
      yield ServerMessageInitial(
        message: message!,
        suppliers: _suppliers,
      );
    
    } on Exception catch  (error, _){
      yield ServerMessageInitError(
        error: error
      );
    }
  }

  Stream<ServerMessageState> _mapServerMessageDeleteToState(
    ServerMessageDelete event
  ) async* {
    yield ServerMessageLoading();

    try {
      final response = await dataManager.serverMessageDeleteRequest(
        id: id
      );
      yield ServerMessageDeleteSuccess(message: response);
    
    } on Exception catch  (error, _){
      yield ServerMessageError(
        error: error
      );
      yield ServerMessageInitial(
        message: message!,
        suppliers: _suppliers
      );
    }
  }
}

