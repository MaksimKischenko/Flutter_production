import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/utils/loger.dart';

part 'init_helppay_services_event.dart';
part 'init_helppay_services_state.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'init_helppay_services_bloc');

class InitHelppayServicesBloc
    extends Bloc<InitHelppayServicesEvent, InitHelppayServicesState> {
  final DataManager dataManager;

  InitHelppayServicesBloc({required this.dataManager})
      : super(InitHelppayServicesLoading()) {
    on<InitHelppayServicesEvent>(_onEvent);
  }

  void _onEvent(
      InitHelppayServicesEvent event, Emitter<InitHelppayServicesState> emit) {
    if (event is InitHelppayServicesInit)
      return _onInitHelppayServicesInit(event, emit);
  }

  void _onInitHelppayServicesInit(InitHelppayServicesInit event,
      Emitter<InitHelppayServicesState> emit) async {
    emit(InitHelppayServicesLoading());

    try {
      String? mode = await PreferencesHelper.getMode();
      _log('NodeType - ${event.nodeType}');
      final response =
          await dataManager.initHelpPayRequest(event.nodeId, event.nodeType);

      final services = response.servicesWrapper?.services.where((element) {
            if (mode == 'DICT') {
              return element.description != null;
            } else
              return true;
          }).toList() ??
          [];

      final getHelppayToken =
          response.sessionToken ?? (await PreferencesHelper.getToken());
      dataManager.initHelppayToken = getHelppayToken ?? '';

      if (response.errorCode == 0) {
        if (event.node != null) {
          int index = dataManager.nodesRouteMap
              .indexWhere((node) => node == event.node);
          if (index != -1) {
            dataManager.nodesRouteMap.removeRange(
              index,
              dataManager.nodesRouteMap.length,
            ); // Remove everything after newNode or its previous version
          }
          dataManager.nodesRouteMap.removeWhere((node) =>
              node == event.node); // Remove existing occurrences of newNode
          dataManager.nodesRouteMap.add(event.node);
        }
        (mode == 'DICT')
            ? emit(
                InitHelppayServicesLoaded(
                  services: services.toList(),
                ),
              )
            : emit(
                InitHelppayNodesLoaded(
                  servicesList: services.toList(),
                  routeMap: dataManager.nodesRouteMap,
                ),
              );
      } else {
        emit(InitHelppayServicesErrorKomplat(
            errorCode: response.errorCode, errorText: response.errorText));
      }
    } catch (error, _) {
      emit(InitHelppayServicesError(error: error));
    }
  }
}
