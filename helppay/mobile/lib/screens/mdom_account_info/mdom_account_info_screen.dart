import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/utils/multiplatform.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets/widgets.dart';

class MdomAccountInfo extends StatefulWidget {
  final PropertyAccount account;

  const MdomAccountInfo({
    Key? key,
    required this.account,
  }) : super(key: key);

  @override
  _MdomAccountInfoState createState() => _MdomAccountInfoState();
}

class _MdomAccountInfoState extends State<MdomAccountInfo> {
  ValueNotifier<MdomPeriodWrapper> period =
      ValueNotifier(MdomPeriodWrapper(period: MdomPeriod.notSet));
  bool onAccrualSelected = false;
  List<MdomService> services = [];
  List<PaymentBilling> payments = [];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: DialogTitle(
          text: context.t.mobileScreens.mdomAccountInfo.tilte,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              SectionTitle(
                  context.t.mobileScreens.mdomAccountInfo.periodSection.tilte),
              const SizedBox(height: 4),
              ValueListenableBuilder<MdomPeriodWrapper>(
                valueListenable: period,
                builder: (context, value, child) => PeriodSelector(
                    period: value,
                    onTap: _onPeriodTap,
                    onPrevTap: () => _updatePeriod(value.prev()),
                    onNextTap: () =>
                        _updatePeriod(period.value = value.next())),
              ),
              Expanded(
                child: BlocBuilder<MdomAccountInfoBloc, MdomAccountInfoState>(
                  builder: (context, state) {
                    Widget? body;
                    if (state is MdomAccountInfoPeriodNotSet) {
                    } else if (state is MdomAccountInfoLoading) {
                    } else if (state is MdomAccountInfoError) {
                      body = Error(context,
                          message: state.error.toString(),
                          onRepeatTap: () => context
                              .read<MdomAccountInfoBloc>()
                              .add(MdomAccountInit(
                                  from: period.value.from!,
                                  to: period.value.to!)));
                    } else if (state is MdomAccountInfoErrorKomplat) {
                      final isTokenError = state.errorCode == 403;

                      body = !isTokenError
                          ?
                          // ? ErrorToken(context,
                          //     message: state.errorMessage,
                          //     onRepeatTap: () => context
                          //         .read<MdomAccountInfoBloc>()
                          //         .add(MdomAccountInit(
                          //             from: period.value.from!,
                          //             to: period.value.to!)))
                          // :
                          Error(context,
                              message: state.errorMessage,
                              onRepeatTap: () => context
                                  .read<MdomAccountInfoBloc>()
                                  .add(MdomAccountInit(
                                      from: period.value.from!,
                                      to: period.value.to!)))
                          : Container();
                      if (isTokenError) {
                        Multiplatform.onExpiredTokenScreenLock(context);
                      }
                    } else if (state is MdomAccountInfoLoaded) {
                      if (services.isEmpty) {
                        services.addAll(state.unRecolculatedServices ?? []);
                      }
                      if (payments.isEmpty) {
                        payments.addAll(
                            state.periodInfo?.paymentsWrapper?.payments ?? []);
                      }
                      final accruals = <String, double>{
                        context.t.mobileScreens.mdomAccountInfo
                            .chargingSectionInfo.remainder: state
                                .periodInfo?.servicesWrapper?.services
                                ?.fold<double>(
                                    0,
                                    (balance, service) =>
                                        balance + (service.balance ?? 0.0)) ??
                            0.0,
                        context
                            .t
                            .mobileScreens
                            .mdomAccountInfo
                            .chargingSectionInfo
                            .fine: state.periodInfo?.servicesWrapper?.services
                                ?.fold<double>(
                                    0,
                                    (fine, service) =>
                                        fine + (service.fine ?? 0.0)) ??
                            0.0,
                        context
                            .t
                            .mobileScreens
                            .mdomAccountInfo
                            .chargingSectionInfo
                            .total: state.periodInfo?.servicesWrapper?.services
                                ?.fold<double>(
                                    0,
                                    (accrued, service) =>
                                        accrued + service.accrued) ??
                            0.0,
                        context
                            .t
                            .mobileScreens
                            .mdomAccountInfo
                            .chargingSectionInfo
                            .paid: state.periodInfo?.paymentsWrapper?.payments
                                ?.fold<double>(
                                    0,
                                    (amount, payment) =>
                                        amount + payment.amount) ??
                            0.0,
                      };
                      body = SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 32),
                            SectionTitle(context.t.mobileScreens.mdomAccountInfo
                                .chargingSection.tilte),
                            const SizedBox(height: 4),
                            AccrualSelectableContainer(
                              onTap: () async {
                                await Navigation.toMdomAccountServiceStatistics(
                                  context: context,
                                  services: services,
                                  state: state,
                                  payments: payments,
                                );
                              },
                              child: ListView.separated(
                                shrinkWrap: true,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: accruals.length - 1,
                                itemBuilder: (context, index) => AccrualItem(
                                  title: accruals.keys.toList()[index],
                                  subtitle: accruals.values
                                      .toList()[index]
                                      .toStringAsFixed(2),
                                  hasForwardIcon: true,
                                  hasTransparentForwardIcon: const {
                                    0: true,
                                    1: false,
                                    2: true
                                  },
                                  index: index,
                                ),
                                separatorBuilder: (context, _) => Divider(
                                    color:
                                        AppStyles.mainColorDark.withOpacity(0.1)
                                    // color: Colors.red,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            SectionTitle(context.t.mobileScreens.mdomAccountInfo
                                .paySection.tilte),
                            AccrualSelectableContainer(
                              onTap: () {
                                Navigation.toMdomAccountInfoPaymentScreen(
                                    context: context, paymentsList: payments);
                              },
                              child: AccrualItem(
                                hasForwardIcon: true,
                                title: accruals.keys.toList().last,
                                subtitle: accruals.values
                                    .toList()
                                    .last
                                    .toStringAsFixed(2),
                              ),
                            ),
                            const SizedBox(height: 4),
                            // if (_onAccrualSelected)
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     SectionTitle(context.t.mobileScreens
                            //         .mdomAccountInfo.serviceSection.tilte),
                            //     ListView.builder(
                            //       shrinkWrap: true,
                            //       padding:
                            //           const EdgeInsets.symmetric(vertical: 8),
                            //       physics:
                            //           const NeverScrollableScrollPhysics(),
                            //       itemCount: state.periodInfo?.servicesWrapper
                            //               ?.services?.length ??
                            //           0,
                            //       itemBuilder: (context, index) =>
                            //           ServiceItem(
                            //         service: state.periodInfo!
                            //             .servicesWrapper!.services![index],
                            //         onTap: _onServiceTap,
                            //       ),
                            //     ),
                            //   ],
                            // )
                            // else
                            //   const SizedBox.shrink(),
                            // const SizedBox(height: 16),
                          ],
                        ),
                      );
                    }
                    return body ?? const SizedBox.shrink();
                  },
                ),
              ),
              //TODO uncomment for aditional changes in payment funtionality
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
              //   child: SafeArea(
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.stretch,
              //       children: [
              //         PayButton(
              //           onPayTap: _onPayTap,
              //         ),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      );

  // ignore: avoid_void_async
  void _onPeriodTap() async {
    final value = await Navigation.toMdomPeriod(
      context: context,
      period: period.value,
    );
    if (value != null) {
      _updatePeriod(value);
    }
  }

  void _updatePeriod(MdomPeriodWrapper value) {
    payments.clear();
    services.clear();
    onAccrualSelected = false;

    period.value = value;
    context
        .read<MdomAccountInfoBloc>()
        .add(MdomAccountInit(from: period.value.from!, to: period.value.to!));
  }

  // void _onServiceTap(MdomService service) {
  //   final sortedServices =
  //       services.where((element) => element.id == service.id).toList();

  //   Navigation.toMdomServiceInfo(
  //     context: context,
  //     service: service,
  //     services: sortedServices,
  //     payments: payments,
  //   );
  // }

  // void _onPayTap() {
  //   Multiplatform.showMessage(
  //       context: context,
  //       title: context.t.mobileScreens.payment.payButtonTitle,
  //       message: context.t.mobileScreens.payment.payButtonMessage,
  //       type: DialogType.info);
  // }
}
