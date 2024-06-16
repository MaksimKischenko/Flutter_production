// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:helppay_core/data/data.dart';


part 'mdom_account_info_event.dart';
part 'mdom_account_info_state.dart';


class MdomAccountInfoBloc extends Bloc<MdomAccountInfoEvent, MdomAccountInfoState> {
  final DataManager dataManager;
  final int supplierId;
  final String account;

  MdomAccountInfoBloc({
    required this.dataManager,
    required this.supplierId,
    required this.account
  }) : super(MdomAccountInfoPeriodNotSet()) {
    on<MdomAccountInfoEvent>(_onEvent);
  }

  void _onEvent(
    MdomAccountInfoEvent event,
    Emitter<MdomAccountInfoState> emit,
  ) {
    if (event is MdomAccountInit) return  _onMdomAccountInit(event, emit);
  }

  void _onMdomAccountInit(
    MdomAccountInit event,
    Emitter<MdomAccountInfoState> emit,
  ) async {
    emit(MdomAccountInfoLoading());

    try {
      final response = await dataManager.accountStatementRequest(
        from: event.from,
        to: event.to.add(const Duration(hours: 23, minutes: 59, seconds: 59)),
        supplierId: supplierId,
        account: account
      );
      if (response.errorCode?.evalue == 0) {     
        if ((response.periods ?? []).isNotEmpty) {
          // AccountStatementPeriod? periodInfo;
          final services = <MdomService>[];
          final unRecolculatedServices = <MdomService>[];
          final payments = <PaymentBilling>[];

          // accumulate periods
          for (final period in response.periods ?? <AccountStatementPeriod>[]) {

            if (period.servicesWrapper?.services?.isNotEmpty ?? false) {

              unRecolculatedServices.addAll(period.servicesWrapper?.services ?? []);
              
              for (final service in period.servicesWrapper!.services!) {
                final serviceIndex = services.indexWhere((e) => e.id == service.id);

                if (serviceIndex > -1) {
                  // accumulate service data
                  final oldService = services[serviceIndex];                  
                  services[serviceIndex] = oldService.copyWith(
                    volume: (Decimal.parse(oldService.volume?.toString() ?? '0') + Decimal.parse(service.volume?.toString() ?? '0')).toDouble(),
                    // balance: (Decimal.parse(oldService.balance?.toString() ?? '0') + Decimal.parse(service.balance?.toString() ?? '0')).toDouble(),
                    balance: service.balance,
                    accrued: (Decimal.parse(oldService.accrued.toString()) + Decimal.parse(service.accrued.toString())).toDouble(),
                    benefit: (Decimal.parse(oldService.benefit?.toString() ?? '0') + Decimal.parse(service.benefit?.toString() ?? '0')).toDouble(),
                    // recalculated: (Decimal.parse(oldService.recalculated?.toString() ?? '0') + Decimal.parse(service.recalculated?.toString() ?? '0')).toDouble(),
                    recalculated: service.recalculated,
                    fine: (Decimal.parse(oldService.fine?.toString() ?? '0') + Decimal.parse(service.fine?.toString() ?? '0')).toDouble(),
                    total: (Decimal.parse(oldService.total.toString()) + Decimal.parse(service.total.toString())).toDouble(),
                    tariff: service.tariff
                  );
                } else {
                  // add service in list
                  services.add(service);
                }
              }
            }
            if (period.paymentsWrapper?.payments?.isNotEmpty ?? false) {
              payments.addAll(period.paymentsWrapper!.payments!);
            }
          }

          // payments?.sort((a, b) => a.id.compareTo(b.id));

          emit(MdomAccountInfoLoaded(
            unRecolculatedServices: unRecolculatedServices,
            periodInfo: AccountStatementPeriod(
              value: '${DateTime.now()}',
              servicesWrapper: ServicesWrapper(
                services: services
              ),
              paymentsWrapper: PaymentsWrapper(
                payments: payments
              )
            )
          ));
        } else {
          emit(const MdomAccountInfoLoaded(
            periodInfo: null
          ));
        }
      } else {
        emit(MdomAccountInfoErrorKomplat(
          errorCode: response.errorCode!.evalue!,
          errorMessage: response.errorCode!.errorText!
        ));
      }
    // ignore: avoid_catches_without_on_clauses
    } catch (error, _) {
      emit(MdomAccountInfoError(
        error: error
      ));
    }
  }
}
