import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/navigation.dart';
import 'package:helppay_web_app/routing/routes.gr.dart';
import 'package:helppay_web_app/screens/mdom_account_info/widgets/widgets.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/utils/utils.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

class MdomAccountInfoScreenBody extends StatefulWidget {
  final PropertyAccount? account;
  final String? supplierTitle;

  const MdomAccountInfoScreenBody(
      {Key? key, required this.account, required this.supplierTitle})
      : super(key: key);

  @override
  _MdomAccountInfoScreenBodyState createState() =>
      _MdomAccountInfoScreenBodyState();
}

class _MdomAccountInfoScreenBodyState extends State<MdomAccountInfoScreenBody> {
  ValueNotifier<MdomPeriodWrapper> period =
      ValueNotifier(MdomPeriodWrapper(period: MdomPeriod.notSet));
  bool _onAccrualSelected = false;
  List<MdomService> services = [];
  List<PaymentBilling> payments = [];

  @override
  Widget build(BuildContext context) => Scaffold(
          appBar: AppBar(
            title: const CabinetMenu(selectedIndex: 0),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 40),
              child: SingleChildScrollView(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 720,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28),
                          child: Text(
                            widget.supplierTitle ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppStyles.supplierTitleColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () => AutoRouter.of(context)
                                        .popAndPush(const MdomAccrualsRoute()),
                                    child: const Icon(
                                      Icons.arrow_back,
                                      size: 20,
                                      color: AppStyles.mainColor,
                                    )),
                                const SizedBox(width: 8),
                                PageTitle(
                                    text:
                                        '${context.t.models.period.title} ${widget.account?.account?.evalue ?? ''}'),
                              ],
                            ),
                            NoSplashButton(
                              withAddIcon: false,
                              onTap: _onPeriodTap,
                              text:
                                  context.t.models.period.selectedNames.notSet,
                            )
                            //PeriodSelectorButton(onPressed: _onPeriodTap)
                          ],
                        ),
                        const SizedBox(height: 40),
                        ValueListenableBuilder<MdomPeriodWrapper>(
                          valueListenable: period,
                          builder: (context, value, child) => PeriodSelector(
                            period: value,
                            onTap: _onPeriodTap,
                            onPrevTap: () => _updatePeriod(value.prev()),
                            onNextTap: () => _updatePeriod(
                              period.value = value.next(),
                            ),
                          ),
                        ),
                        BlocBuilder<MdomAccountInfoBloc, MdomAccountInfoState>(
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

                              body = isTokenError
                                  ? ErrorToken(context,
                                      message: state.errorMessage,
                                      onRepeatTap: () => context
                                          .read<MdomAccountInfoBloc>()
                                          .add(MdomAccountInit(
                                              from: period.value.from!,
                                              to: period.value.to!)))
                                  : Error(context,
                                      message: state.errorMessage,
                                      onRepeatTap: () => context
                                          .read<MdomAccountInfoBloc>()
                                          .add(MdomAccountInit(
                                              from: period.value.from!,
                                              to: period.value.to!)));
                              if (isTokenError) {
                                //  Multiplatform.onExpiredTokenScreenLock(context);
                                Future.delayed(
                                    const Duration(seconds: 2),
                                    () => AutoRouter.of(context)
                                        .pushAndPopUntil(AuthRoute(),
                                            predicate: (route) => false));
                              }
                            } else if (state is MdomAccountInfoLoaded) {
                              if (services.isEmpty) {
                                services
                                    .addAll(state.unRecolculatedServices ?? []);
                              }
                              if (payments.isEmpty) {
                                payments.addAll(state.periodInfo
                                        ?.paymentsWrapper?.payments ??
                                    []);
                              }
                              final accruals = <String, double>{
                                context.t.mobileScreens.mdomAccountInfo
                                    .chargingSectionInfo.remainder: state
                                        .periodInfo?.servicesWrapper?.services
                                        ?.fold<double>(
                                            0,
                                            (balance, service) =>
                                                balance +
                                                (service.balance ?? 0.0)) ??
                                    0.0,
                                context.t.mobileScreens.mdomAccountInfo
                                    .chargingSectionInfo.fine: state
                                        .periodInfo?.servicesWrapper?.services
                                        ?.fold<double>(
                                            0,
                                            (fine, service) =>
                                                fine + (service.fine ?? 0.0)) ??
                                    0.0,
                                context.t.mobileScreens.mdomAccountInfo
                                    .chargingSectionInfo.total: state
                                        .periodInfo?.servicesWrapper?.services
                                        ?.fold<double>(
                                            0,
                                            (accrued, service) =>
                                                accrued + service.accrued) ??
                                    0.0,
                                context.t.mobileScreens.mdomAccountInfo
                                    .chargingSectionInfo.paid: state
                                        .periodInfo?.paymentsWrapper?.payments
                                        ?.fold<double>(
                                            0,
                                            (amount, payment) =>
                                                amount + payment.amount) ??
                                    0.0,
                              };
                              body = Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(height: 32),
                                  SectionTitle(context.t.mobileScreens
                                      .mdomAccountInfo.chargingSection.tilte),
                                  const SizedBox(height: 4),
                                  AccrualSelectableContainer(
                                    onTap: () => setState(
                                        () => _onAccrualSelected = true),
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 16),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: accruals.length - 1,
                                      itemBuilder: (context, index) =>
                                          AccrualItem(
                                        title: accruals.keys.toList()[index],
                                        subtitle: accruals.values
                                            .toList()[index]
                                            .toStringAsFixed(2),
                                      ),
                                      separatorBuilder: (context, _) => Divider(
                                          color: AppStyles.mainColorDark
                                              .withOpacity(0.1)
                                          // color: Colors.red,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  SectionTitle(context.t.mobileScreens
                                      .mdomAccountInfo.paySection.tilte),
                                  AccrualSelectableContainer(
                                    onTap: () {
                                      Navigation.toMdomAccountInfoPaymentScreen(
                                          context: context,
                                          paymentsList: payments);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left:
                                              16), //symmetric(vertical: 8, horizontal: 16),
                                      child: AccrualItem(
                                        hasForwardIcon: true,
                                        title: accruals.keys.toList().last,
                                        subtitle: accruals.values
                                            .toList()
                                            .last
                                            .toStringAsFixed(2),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  if (_onAccrualSelected)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SectionTitle(context
                                            .t
                                            .mobileScreens
                                            .mdomAccountInfo
                                            .serviceSection
                                            .tilte),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: state
                                                  .periodInfo
                                                  ?.servicesWrapper
                                                  ?.services
                                                  ?.length ??
                                              0,
                                          itemBuilder: (context, index) =>
                                              ServiceItem(
                                            service: state
                                                .periodInfo!
                                                .servicesWrapper!
                                                .services![index],
                                            onTap: _onServiceTap,
                                          ),
                                        ),
                                      ],
                                    )
                                  else
                                    const SizedBox.shrink(),
                                  const SizedBox(height: 16),
                                ],
                              );
                            }
                            return body ?? const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          persistentFooterAlignment: AlignmentDirectional.center,
          persistentFooterButtons: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: SizedBox(
                width: 200,
                child: PayButton(
                  onPayTap: _onPayTap,
                ),
              ),
            )
          ]);

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
    _onAccrualSelected = false;

    period.value = value;
    context
        .read<MdomAccountInfoBloc>()
        .add(MdomAccountInit(from: period.value.from!, to: period.value.to!));
  }

  void _onServiceTap(MdomService service) {
    final sortedServices =
        services.where((element) => element.id == service.id).toList();

    Navigation.toMdomServiceInfo(
      context: context,
      service: service,
      services: sortedServices,
      payments: payments,
    );
  }

  void _onPayTap() {
    Multiplatform.showMessage(
      context: context,
      title: context.t.mobileScreens.payment.payButtonTitle,
      message: context.t.mobileScreens.payment.payButtonMessage,
      type: DialogType.info,
    );
  }
}
