import 'package:fl_qr_module/blocs/blocs.dart';
import 'package:fl_qr_module/generated/translations.g.dart';
import 'package:fl_qr_module/models/models.dart';
import 'package:fl_qr_module/navigation.dart';
import 'package:fl_qr_module/screens/mdom_qr/services_qr_screen.dart';
import 'package:fl_qr_module/styles.dart';
import 'package:fl_qr_module/utils/utils.dart';
import 'package:fl_qr_module/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  static const pageRoute = '/main';

  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    // Navigation.toQrScan(context: context);
  }

  final pages = <MenuTabWrapper>[
    const MenuTabWrapper(
      tab: MenuTab.paymentQr,
      child: ServicesQrScreen(key: Key('PaymentQr')),
    ),
    const MenuTabWrapper(tab: MenuTab.qrScan, child: SizedBox.shrink()),
  ];

  @override
  Widget build(BuildContext context) => BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) => Scaffold(
          extendBody: true,
          backgroundColor: AppStyles.scaffoldColor,
          body: Stack(
            children: [
              IndexedStack(
                index: pages.indexWhere((e) => e.tab == state.tab),
                children: pages.map((e) => e.child).toList(),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigation(
            currentIndex: pages.indexWhere((e) => e.tab == state.tab),
            onTap: (MenuTab? tab) async {
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
                context.read<MenuBloc>().add(MenuTabUpdate(tab: tab));
              }
            },
            items: [
              // NavItem(
              //   iconName: 'qr_code',
              //   title: context.t.mobileScreens.main.menu.qrPayment,
              //   tab: MenuTab.paymentQr,
              // ),
              NavItem(
                iconName: 'qr_code_scan',
                title: context.t.mobileScreens.main.menu.scanQr,
                tab: MenuTab.qrScan,
              ),
            ],
          ),
        ),
      );
}
