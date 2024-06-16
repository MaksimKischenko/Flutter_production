import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bpc_nkfo/data/data.dart';
import 'package:bpc_nkfo/injection_component.dart';
import 'package:bpc_nkfo/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:kotlin_flavor/scope_functions.dart';

part 'info_event.dart';
part 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  final DataManager _dataManager;
  
  InfoBloc() : _dataManager = InjectionComponent.getDependency<DataManager>(), super(InfoLoading());

  @override
  Stream<InfoState> mapEventToState(
    InfoEvent event,
  ) async* {
    if (event is InfoInit) {
      yield* _mapInfoInitToState(event);
    }
  }

  Stream<InfoState> _mapInfoInitToState(
    InfoInit event
  ) async* {
    yield InfoLoading();

    final main = <String, dynamic>{};
    final contacts = <String, dynamic>{};
    List<Service> services;

    _dataManager.informationResponse?.let((info) {
      if (info.fullName.isNotNullorEmpty) main.putIfAbsent('Полное наименование о гос рег.', () => info.fullName);
      if (info.shortName.isNotNullorEmpty) main.putIfAbsent('Сокращенное наименование о гос. рег.', () => info.shortName);
      if (info.address.isNotNullorEmpty) main.putIfAbsent('Полный адрес', () => info.address);
      if (info.mfo.isNotNullorEmpty) main.putIfAbsent('МФО', () => info.mfo);
      if (info.accNum.isNotNullorEmpty) main.putIfAbsent('Номер счета', () => info.accNum);
      main.putIfAbsent('УНП', () => info.unp);
      if (info.fio.isNotNullorEmpty) main.putIfAbsent('Лицо подписывающее договор', () => info.fio);
      if (info.post.isNotNullorEmpty) main.putIfAbsent('Должность лица подписывающего договор', () => info.post);
      if (info.basis.isNotNullorEmpty) main.putIfAbsent('Действует на основании договора', () => info.basis);
      
      // mainList.add(Tuple2("Предполагаемое число требований", info.usersCount ?? 0));
      main.putIfAbsent('Статус подключения', () => info.confirmStatus == 1
        ? 'Регистрация подтверждена'
        : 'Решение по регистрации пользователя не принято'
      );
    });
    //contactsList
    _dataManager.informationResponse?.contacts?.let((it) {
      for (final item in it) {
        contacts.putIfAbsent(item.contact, () => '${item.position}; ${item.phone}');
      }
    });
    //servicesList
    services = _dataManager.servicesList;

    yield InfoLoaded(
      main: main,
      contacts: contacts,
      services: services
    );
  }
}
