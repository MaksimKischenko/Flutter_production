import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';
import 'package:web_cabinet_nkfo/models/models.dart';

part 'server_messages_event.dart';
part 'server_messages_state.dart';

class ServerMessagesBloc extends Bloc<ServerMessagesEvent, ServerMessagesState> {
  DataManager dataManager; 

  ServerMessagesBloc() : dataManager = InjectionComponent.getDependency<DataManager>(), 
  super(ServerMessagesInitLoading());

  DateTime? _dateFrom;
  DateTime? _dateTo;
  ServerMessageStatus _status = ServerMessageStatus.all;
  String? _title; 
  String? _text;
  ServerMessageSort _sort = AppConfig.serverMessagesDefaultSort;
  bool _sortAscending = AppConfig.serverMessagesDefaultSortAscending;
  bool _isLoadMoreAvaiable = true;
  bool _getIsAvaliable = true;
  bool _postIsAvaliable = true;
  bool _patchIsAvaliable = true;
  bool _deleteIsAvaliable = true;

  List<ServerMessage> _messages = [];
  List<ServerMessage> _messagesUpdated = [];


  @override
  Stream<ServerMessagesState> mapEventToState(
    ServerMessagesEvent event,
  ) async* {
    if (event is ServerMessagesInit) {
      yield* _mapServerMessagesInitToState(event);
    } else if (event is ServerMessagesLoad) {
      yield* _mapServerMessagesLoadToState(event);
    } else if (event is ServerMessagesLoadMore) {
      yield* _mapServerMessagesLoadMoreToState(event);
    } else if (event is ServerMessagesIncomeDeleteMessage) {
      // income deletion from other blocs
      yield* _mapServerMessagesIncomeDeleteMessageToState(event);
    } else if (event is ServerMessagesDeleteMessage) {
      // call delete method
      yield* _mapServerMessagesDeleteMessageToState(event);
    } else if (event is ServerMessagesIncomeUpdateMessage) {
      yield* _mapServerMessagesIncomeUpdateMessageToState(event);
    } else if (event is ServerMessagesNewServerMessage) {
      yield* _mapServerMessagesNewServerMessageToState(event);
    }
  }

  Stream<ServerMessagesState> _mapServerMessagesInitToState(
    ServerMessagesInit event
  ) async* {

    _getIsAvaliable =  dataManager.userRights.isAvailable(EntityMethod.getM, EntityName.serverMessage);
    _postIsAvaliable = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.serverMessage);
    _patchIsAvaliable = dataManager.userRights.isAvailable(EntityMethod.patchM, EntityName.serverMessage);
    _deleteIsAvaliable = dataManager.userRights.isAvailable(EntityMethod.deleteM, EntityName.serverMessage);

    yield ServerMessagesInitLoading();

    yield ServerMessagesLoaded(
      messages: _messages,
      sort: _sort,
      dateFrom: _dateFrom,
      dateTo: _dateTo,
      title: _title,
      text: _text,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable:  _isLoadMoreAvaiable,
      getIsAvaliable: _getIsAvaliable,
      postIsAvaliable: _postIsAvaliable,
      patchIsAvaliable: _patchIsAvaliable,
      deleteIsAvaliable: _deleteIsAvaliable
    );
  }


  Stream<ServerMessagesState> _mapServerMessagesLoadToState(
    ServerMessagesLoad event
  ) async* {
    yield ServerMessagesLoading();

    try {
      final status = event.status ?? ServerMessageStatus.all;
      final response = _getIsAvaliable? await dataManager.getSupplierServerMessagesRequest(
        count: event.loadCount,
        sort: event.sort ?? AppConfig.serverMessagesDefaultSort,
        sortAscending: event.sortAscending ?? AppConfig.serverMessagesDefaultSortAscending,
        dateFrom: event.dateFrom,
        dateTo: event.dateTo,
        status: event.status,
        statusName: event.statusName,
        heading: event.title,
        text: event.text
      ) : <ServerMessage>[];

      _dateFrom = event.dateFrom;
      _dateTo = event.dateTo;
      _status = status;
      _title = event.title;
      _text = event.text;
      if (event.sort != null) _sort = event.sort!;
      if (event.sortAscending != null) _sortAscending = event.sortAscending!;

      _messages = response;
      _isLoadMoreAvaiable = !(response.length < AppConfig.serverMessagesGetLoadCount);
    
    } on Exception catch (error, _){
      yield ServerMessagesError(
        error: error
      );
    }

    yield _getIsAvaliable? ServerMessagesLoaded(
      messages: _messages,
      sort: _sort,
      dateFrom: _dateFrom,
      dateTo: _dateTo,
      title: _title,
      text: _text,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable:  _isLoadMoreAvaiable,
      getIsAvaliable: _getIsAvaliable,
      postIsAvaliable: _postIsAvaliable,
      patchIsAvaliable: _patchIsAvaliable,
      deleteIsAvaliable: _deleteIsAvaliable
    ) : const ServerMessageGetNotAllow(
      message: AppConfig.getIsNotAvaliableServerMessage
    );
  }

  Stream<ServerMessagesState> _mapServerMessagesLoadMoreToState(
    ServerMessagesLoadMore event
  )  async* {
    yield ServerMessagesLoading();

    try {
      final response = await dataManager.getSupplierServerMessagesRequest(
        count: AppConfig.serverMessagesGetLoadCount,
        offset: event.offset,
        sort: _sort,
        sortAscending: _sortAscending,
        dateFrom: _dateFrom,
        dateTo: _dateTo,
        status: _status,
        heading: _title,
        text: _text
      );

      _messages.addAll(response);
      _isLoadMoreAvaiable = !(response.length < AppConfig.serverMessagesGetLoadCount);
     
    } on Exception catch (error, _){
      yield ServerMessagesError(
        error: error
      );
    }

    yield ServerMessagesLoaded(
      messages: _messages,
      sort: _sort,
      dateFrom: _dateFrom,
      dateTo: _dateTo,
      title: _title,
      text: _text,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable:  _isLoadMoreAvaiable,
      getIsAvaliable: _getIsAvaliable,
      postIsAvaliable: _postIsAvaliable,
      patchIsAvaliable: _patchIsAvaliable,
      deleteIsAvaliable: _deleteIsAvaliable      
    );
  }

  Stream<ServerMessagesState> _mapServerMessagesIncomeDeleteMessageToState(
    ServerMessagesIncomeDeleteMessage event
  ) async* {
    yield ServerMessagesLoading();

    // final index = _messages.indexWhere((e) => e.id == event.message.id);
    // if(index > -1) {
    //   _messages.removeAt(index);
    // }

    final response = await dataManager.getSupplierServerMessagesRequest();
    //_messages.removeWhere((e) => e.id == event.messageId);

    yield ServerMessagesLoaded(
      messages: response,
      sort: _sort,
      dateFrom: _dateFrom,
      dateTo: _dateTo,
      title: _title,
      text: _text,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable:  _isLoadMoreAvaiable,
      getIsAvaliable: _getIsAvaliable,
      postIsAvaliable: _postIsAvaliable,
      patchIsAvaliable: _patchIsAvaliable,
      deleteIsAvaliable: _deleteIsAvaliable      
    );
  }

  Stream<ServerMessagesState> _mapServerMessagesDeleteMessageToState(
    ServerMessagesDeleteMessage event
  ) async* {
    yield ServerMessagesLoading();
    try {
     await dataManager.serverMessageDeleteRequest(id: event.id);
      _messages.removeWhere((e) => e.id == event.id);
    
    yield ServerMessagesDeleteSuccess(
      event.id
    );

     
    } on Exception catch (error, _){
      yield ServerMessagesError(
        error: error
      );
    }

    yield ServerMessagesLoaded(
      messages: _messages,
      sort: _sort,
      dateFrom: _dateFrom,
      dateTo: _dateTo,
      title: _title,
      text: _text,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable:  _isLoadMoreAvaiable,
      getIsAvaliable: _getIsAvaliable,
      postIsAvaliable: _postIsAvaliable,
      patchIsAvaliable: _patchIsAvaliable,
      deleteIsAvaliable: _deleteIsAvaliable     
    );
  }

  Stream<ServerMessagesState> _mapServerMessagesIncomeUpdateMessageToState(
    ServerMessagesIncomeUpdateMessage event
  ) async* {
    yield ServerMessagesLoading();


    try {
      final response = await dataManager.getSupplierServerMessagesRequest();
      _messagesUpdated = response;
    } on Exception catch (error, _){
      yield ServerMessagesError(
        error: error
      );

    // final index = _messages.indexWhere((e) => e.id == event.message.id);
    // if (index > -1) {
    //   _messages[index] = event.message;
    // }
    yield ServerMessagesLoaded(
      messages: _messagesUpdated,
      sort: _sort,
      dateFrom: _dateFrom,
      dateTo: _dateTo,
      title: _title,
      text: _text,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable:  _isLoadMoreAvaiable,
      getIsAvaliable: _getIsAvaliable,
      postIsAvaliable: _postIsAvaliable,
      patchIsAvaliable: _patchIsAvaliable,
      deleteIsAvaliable: _deleteIsAvaliable      
    );
  }
 }

   Stream<ServerMessagesState> _mapServerMessagesNewServerMessageToState(
    ServerMessagesNewServerMessage event
  ) async* {
    yield ServerMessagesLoading();

    _messages.insert(0, event.message);

    yield ServerMessagesLoaded(
      messages: _messages,
      sort: _sort,
      dateFrom: _dateFrom,
      dateTo: _dateTo,
      title: _title,
      text: _text,
      sortAscending: _sortAscending,
      isLoadMoreAvaiable:  _isLoadMoreAvaiable,
      getIsAvaliable: _getIsAvaliable,
      postIsAvaliable: _postIsAvaliable,
      patchIsAvaliable: _patchIsAvaliable,
      deleteIsAvaliable: _deleteIsAvaliable      
    );
  }
}


