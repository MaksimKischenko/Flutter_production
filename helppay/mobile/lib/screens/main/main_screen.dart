import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/blocs/blocs.dart';
import 'package:helppay/models/models.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay/screens/mdom_qr/services_qr_screen.dart';
import 'package:helppay/screens/screens.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

class MainScreen extends StatefulWidget {
  static const pageRoute = '/main';

  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  bool _isVisible = true;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  final pages = <MenuTabWrapper>[
    const MenuTabWrapper(
      tab: MenuTab.paymentsHistory,
      child: PaymentsHistoryScreen(key: Key('HistoryScreen')),
    ),
    const MenuTabWrapper(
      tab: MenuTab.products,
      child: ProductsScreen(key: Key('AccountsScreen')),
    ),
    const MenuTabWrapper(
      tab: MenuTab.paymentQr,
      child: ServicesQrScreen(key: Key('PaymentQr')),
    ),
    if (CoreConfig.appFlavour == AppFlavour.full)
      const MenuTabWrapper(
        tab: MenuTab.accruals,
        child: MdomAccrualsScreen(key: Key('MdomAccrualsScreen')),
      ),
    const MenuTabWrapper(
      tab: MenuTab.profile,
      child: ProfileScreen(key: Key('ProfileScreen')),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1.1),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<MenuBloc, MenuState>(
        listener: (context, state) {
          _isVisible = state.isVisible;
          pages[1] = const MenuTabWrapper(
            tab: MenuTab.products,
            child: ProductsScreen(key: Key('AccountsScreen')),
          );
          if (_isVisible) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
        },
        builder: (context, state) => Scaffold(
          extendBody: true,
          backgroundColor: AppStyles.scaffoldColor,
          body: IndexedStack(
            index: pages.indexWhere((e) => e.tab == state.tab),
            children: pages.map((e) => e.child).toList(),
          ),
          bottomNavigationBar: SlideTransition(
            position: _offsetAnimation,
            child: BottomNavigation(
              currentIndex: pages.indexWhere((e) => e.tab == state.tab),
              onTap: (tab) async {
                if (tab == MenuTab.qrScan) {
                  final data = await Navigation.toQrScan(context: context);
                  if (data != null) {
                    Multiplatform.showQrPayDecisionMessage(
                      context: context,
                      qrEripData: data,
                      dangetType: DecisionType.notDanger,
                      action: () async {
                        await Navigation.toPayment(
                          context: context,
                          data: data,
                        );
                      },
                      dialogTitle: context
                          .t.mobileScreens.qrPayment.qrPaymentDecisionTitle,
                      buttonTitle:
                          context.t.mobileScreens.qrPayment.confirmButtonTitle,
                      cancelButtonTitle:
                          context.t.mobileScreens.qrPayment.cancelButtonTitle,
                    );
                  }
                } else {
                  context
                      .read<MenuBloc>()
                      .add(MenuTabUpdate(tab: tab, isBnbCardAdd: false));
                }
              },
              items: [
                NavItem(
                  iconName: 'menu_history',
                  title: context.t.mobileScreens.main.menu.history,
                  tab: MenuTab.paymentsHistory,
                ),
                NavItem(
                  iconName: 'menu_accounts',
                  title: context.t.mobileScreens.main.menu.products,
                  tab: MenuTab.products,
                ),
                NavItem(
                  iconName: 'menu_home',
                  title: context.t.mobileScreens.main.menu.qrPayment,
                  tab: MenuTab.paymentQr,
                ),
                if (CoreConfig.appFlavour == AppFlavour.full)
                  NavItem(
                    iconName: 'menu_payments',
                    title: context.t.mobileScreens.main.menu.accruals,
                    tab: MenuTab.accruals,
                  ),
                NavItem(
                  iconName: 'menu_profile',
                  title: context.t.mobileScreens.main.menu.profile,
                  tab: MenuTab.profile,
                ),
                NavItem(
                  iconName: 'menu_home',
                  title: context.t.mobileScreens.main.menu.scanQr,
                  tab: MenuTab.qrScan,
                ),
              ],
            ),
          ),
        ),
      );
}
