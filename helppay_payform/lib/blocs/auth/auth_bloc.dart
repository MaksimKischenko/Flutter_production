import 'package:equatable/equatable.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/models/models.dart';
import 'package:helppay_payform_app/route_helper.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  final DataManager dataManager;
  final DynamicConfig config;

  AuthBloc({
    required this.dataManager,
    required this.config,
  }) : super(AuthLoading()) {
    on<AuthEvent>(_onEvent);
  }

  List<Payment> payments = [];

  void _onEvent(AuthEvent event, Emitter<AuthState> emit) {
    if (event is AuthRun) return _onAuthRun(event, emit);
    if (event is AuthLogOut) return _onAuthLogOut(event, emit);
  }

  void _onAuthRun(AuthRun event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final url = RouteHelper.parsePathWithStringParams(event.path,
        isHashStrategy: config.isUrlHashStrategy);

    final getPaymentsToken = event.token;

    try {
      if (getPaymentsToken != null || getPaymentsToken!.isNotEmpty) {
        final response = await dataManager.paymentsRequest(getPaymentsToken);
        final mode = dataManager.mode;
        payments = response.payments ?? [];

        if (response.error?.isEmpty ?? false) throw Exception(response.error);

        await PreferencesHelper.setToken(getPaymentsToken);
        await PreferencesHelper.setMode(mode);

        dataManager.getPaymentsToken = getPaymentsToken; //WORKT
      }

      emit(AuthAuthorized(
          needToNavigate: url.key == '' || url.key == '/',
          maxAmount: dataManager.maxAmount,
          token: dataManager.getPaymentsToken ?? '',
          payments: payments,
          returnUri: dataManager.returnUri,
          confirmUri: dataManager.confirmUri,
          login: dataManager.login ?? '',
          password: dataManager.password,
          payerId: dataManager.payerId,
          deviceType: dataManager.deviceType));
    } catch (error, _) {
      emit(AuthError(error: error));
    }
  }

  void _onAuthLogOut(AuthLogOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final response = await dataManager.deleteHelppaySessionRequest();

    if (response.errorCode == 0) {
      dataManager.initHelppayToken = '';
      dataManager.password = '';
      dataManager.login = null;
      dataManager.getPaymentsToken = null;
      await PreferencesHelper.setToken(null ?? '');
      await clear();
      emit(AuthUnauthorized());
    } else {
      emit(
        AuthErrorKomplat(
          errorCode: response.errorCode,
          errorText: response.errorText,
          request: RequestType.logOut,
        ),
      );
    }
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    dataManager
      ..getPaymentsToken = (json['sessionToken'] as String?) ?? ''
      ..returnUri = (json['returnUri'] as String?) ?? ''
      ..login = (json['login'] as String?) ?? ''
      ..password = (json['password'] as String?) ?? ''
      ..deviceType = (json['deviceType'] as String?) ?? ''
      ..confirmUri = (json['confirmUri'] as String?) ?? ''
      ..payerId = (json['payerId'] as String?) ?? ''
      ..maxAmount = (json['maxAmount'] as double?) ?? 0;

    return AuthAuthorized(
        needToNavigate: (json['needToNavigate'] as bool?) ?? true,
        maxAmount: (json['maxAmount'] as double?) ?? 0,
        token: (json['sessionToken'] as String?) ?? '',
        payments: payments,
        // services: services,
        returnUri: (json['returnUri'] as String?) ?? '',
        confirmUri: (json['confirmUri'] as String?) ?? '',
        login: (json['login'] as String?) ?? '',
        password: (json['password'] as String?) ?? '',
        payerId: (json['payerId'] as String?) ?? '',
        deviceType: (json['deviceType'] as String?) ?? '');
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    if (state is AuthAuthorized) {
      return {
        'returnUri': state.returnUri,
        'confirmUri': state.confirmUri,
        'login': state.login,
        'sessionToken': state.token,
        'password': state.password,
        'deviceType': state.deviceType,
        'payerId': state.payerId,
        'maxAmount': state.maxAmount,
        'needToNavigate': state.needToNavigate,
      };
    }
    return null;
  }

  @override
  Future<void> clear() async {
    super.clear();
    payments = [];
    // Reset the state of your bloc to the initial state here
  }
}
