// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/utils/loger.dart';
import 'package:bpc/utils/utils.dart';
import 'package:equatable/equatable.dart';

part 'info_event.dart';
part 'info_state.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'auth_mdom_bloc');

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  final DataManager dataManager;

  InfoBloc({
    required this.dataManager,
  }) : super(InfoLoading()) {
    on<InfoEvent>(_onEvent);
  }

  void _onEvent(
    InfoEvent event,
    Emitter<InfoState> emit,
  ) {
    if (event is InfoInit) return _onInfoInit(event, emit);
  }

  void _onInfoInit(
    InfoInit event,
    Emitter<InfoState> emit,
  ) async {
    emit(InfoLoading());

    final main = <String, dynamic>{};

    // main
    dataManager.userParams?.forEach((param) {
      if (param.evalue != null && (param.evalue?.isNotEmpty ?? false)) {
        main.putIfAbsent(param.name, () => param.evalue);
      }
    });
    _log('User params - ${dataManager.userParams}');
    if (dataManager.informationResponse != null) {
      final info = dataManager.informationResponse!;
      if (info.fullName.isNotNullorEmpty)
        main.putIfAbsent('Полное наименование о гос рег.', () => info.fullName);
      if (info.shortName.isNotNullorEmpty)
        main.putIfAbsent(
            'Сокращенное наименование о гос. рег.', () => info.shortName);
      if (info.address.isNotNullorEmpty)
        main.putIfAbsent('Полный адрес', () => info.address);
      if (info.mfo.isNotNullorEmpty) main.putIfAbsent('МФО', () => info.mfo);
      if (info.accNum.isNotNullorEmpty)
        main.putIfAbsent('Номер счета', () => info.accNum);
      main.putIfAbsent('УНП', () => info.unp);
      if (info.fio.isNotNullorEmpty)
        main.putIfAbsent('Лицо подписывающее договор', () => info.fio);
      if (info.post.isNotNullorEmpty)
        main.putIfAbsent(
            'Должность лица подписывающего договор', () => info.post);
      if (info.basis.isNotNullorEmpty)
        main.putIfAbsent('Действует на основании договора', () => info.basis);

      // mainList.add(Tuple2("Предполагаемое число требований", info.usersCount ?? 0));
      main.putIfAbsent(
          'Статус подключения',
          () => info.confirmStatus == 1
              ? 'Регистрация подтверждена'
              : 'Решение по регистрации пользователя не принято');
    }

    emit(InfoLoaded(
      mainInfoList: main,
      contactsList: dataManager.informationResponse?.contacts ?? [],
      servicesList: dataManager.servicesList,
    ));
  }
}
