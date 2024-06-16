import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/screens/screens.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MainScreenMobile extends StatefulWidget {
  static const pageRoute = '/main';

  const MainScreenMobile({
    Key? key,
  }) : super(key: key);

  @override
  State<MainScreenMobile> createState() => _MainScreenMobileState();
}

class _MainScreenMobileState extends State<MainScreenMobile> {
  final pages = <MenuTabWrapper>[
    const MenuTabWrapper(
      tab: MenuTab.claims,
      child: ClaimsScreen(
        key: Key('ClaimsScreen'),
      ),
    ),
    const MenuTabWrapper(
      tab: MenuTab.payments,
      child: PaymentsScreen(
        key: Key('PaymentsScreen'),
      ),
    ),
    const MenuTabWrapper(
      tab: MenuTab.servicesQr,
      child: ServicesQrScreen(
        key: Key('ServicesQrScreen'),
      ),
    ),
    const MenuTabWrapper(
        tab: MenuTab.polls,
        child: PollsListScreen(
          key: Key('PollsListScreen'),
        )
        // child: ServicesQrScreen(
        //   key: Key('ServicesQrScreen')
        // ),
        ),
    const MenuTabWrapper(
      tab: MenuTab.more,
      child: FeaturesScreen(
        key: Key('FeaturesScreen'),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) => BlocConsumer<MenuBloc, MenuState>(
        listener: (context, state) {
          // _isVisible = state.isVisible;
          // if (_isVisible) {
          //   _controller.reverse();
          // } else {
          //   _controller.forward();
          // }
        },
        builder: (context, state) => Scaffold(
          // extendBody: true,
          // body: Builder(
          //   builder: (context) {
          //     if (state.tab == MenuTab.claims) {
          //       final _dataManager = InjectionComponent.getDependency<DataManager>();

          //       return BlocProvider<ClaimsBloc>(
          //         create: (context) => ClaimsBloc(
          //           dataManager: _dataManager,
          //         ),
          //         child: ClaimsScreen(
          //           availableFeatures: _dataManager.availableFeatures,
          //           initialFilters: ClaimsFilterData(
          //             service: _dataManager.currentService,
          //             dateFrom: _dataManager.currentDateFrom,
          //             dateTo: _dataManager.currentDateTo,
          //             status: ClaimStatus.all,
          //           ),
          //         ),
          //       );
          //     } else if (state.tab == MenuTab.payments) {
          //       final _dataManager = InjectionComponent.getDependency<DataManager>();

          //       return BlocProvider<PaymentsBloc>(
          //         create: (context) => PaymentsBloc(
          //           dataManager: InjectionComponent.getDependency<DataManager>(),
          //         ),
          //         child: PaymentsScreen(
          //           availableFeatures: _dataManager.availableFeatures,
          //           initialFilters: PaymentsFilterData(
          //             service: _dataManager.currentService,
          //             dateType: PaymentDateType.transfer,
          //             dateFrom: _dataManager.currentDateFrom,
          //             dateTo: _dataManager.currentDateTo,
          //             status: PaymentStatus.all,
          //           ),
          //         ),
          //       );
          //     } else if (state.tab == MenuTab.servicesQr) {
          //       final _dataManager = InjectionComponent.getDependency<DataManager>();

          //       return BlocProvider<ServicesQrBloc>(
          //         create: (context) => ServicesQrBloc(
          //           dataManager: _dataManager,
          //         )..add(ServicesQrInit()),
          //         child: const ServicesQrScreen(),
          //       );
          //     } else if (state.tab == MenuTab.polls) {
          //       // TODO: provide polls_screen here
          //       return const SizedBox.shrink();
          //     } else if (state.tab == MenuTab.more) {
          //       final _dataManager = InjectionComponent.getDependency<DataManager>();

          //       return FeaturesScreen(
          //         key: const Key('FeaturesScreen'),
          //         isCredentialsSaveChecked: _dataManager.isCredentialsSaveChecked,
          //       );
          //     } else {
          //       return const SizedBox.shrink();
          //     }
          //   },
          // ),
          body: IndexedStack(
            index: pages.indexWhere((e) => e.tab == state.tab),
            children: pages.map((e) => e.child).toList(),
          ),
          bottomNavigationBar: BottomNavigation(
            currentIndex: pages.indexWhere((e) => e.tab == state.tab),
            onTap: (tab) {
              // if (tab == MenuTab.qrScan) {
              //   Navigation.toQrScan(context: context);
              // } else {
              //   context.read<MenuBloc>().add(MenuTabUpdate(tab));
              // }
              context.read<MenuBloc>().add(MenuTabUpdate(tab));
            },
            items: const [
              NavItem(
                iconName: 'menu_claims',
                // title: context.t.screens.main.menu.products,
                title: 'Требования',
                tab: MenuTab.claims,
              ),
              // if (AppConfig.appFlavour == AppFlavour.full)
              NavItem(
                iconName: 'menu_payments',
                // title: context.t.screens.main.menu.accruals,
                title: 'Платежи',
                tab: MenuTab.payments,
              ),
              NavItem(
                iconName: 'menu_qr',
                // title: context.t.screens.main.menu.profile,
                title: 'QR-коды услуг',
                tab: MenuTab.servicesQr,
              ),
              NavItem(
                iconName: 'menu_polls',
                // title: context.t.screens.main.menu.history,
                title: 'Голосования',
                tab: MenuTab.polls,
              ),
              NavItem(
                iconName: 'menu_more',
                // title: context.t.screens.main.menu.scanQr,
                title: 'Ещё',
                tab: MenuTab.more,
              ),
            ],
          ),
        ),
      );
}
