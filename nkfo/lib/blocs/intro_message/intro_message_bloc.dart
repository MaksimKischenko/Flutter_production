import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_cabinet_nkfo/data/data_manager.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';
import 'package:web_cabinet_nkfo/models/models.dart';

part 'intro_message_event.dart';
part 'intro_message_state.dart';


class IntroMessageBloc extends Bloc<IntroMessageEvent, IntroMessageState> {
  DataManager dataManager;
  bool isSaveMessageAvailable = false;

  IntroMessageBloc() : dataManager = InjectionComponent.getDependency<DataManager>(), 
  super(IntroMessageInitial());

  @override
  Stream<IntroMessageState> mapEventToState(
    IntroMessageEvent event,
  ) async* {
    if (event is IntroMessageSave) {
      yield* _mapSaveToState(event);
    }
  }

  Stream<IntroMessageState> _mapSaveToState(
    IntroMessageSave event
  ) async* {
    yield IntroMessageLoading();

    isSaveMessageAvailable = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.startMessage);
    log('$isSaveMessageAvailable');
    
    try {
      if(isSaveMessageAvailable) {
        await dataManager.startMessageRequest(message: event.message);  
        yield IntroMessageSuccess();
      }
    } on Exception catch  (error, _)  {
      yield IntroMessageError(
        error: error
      );
    }
  }
}
