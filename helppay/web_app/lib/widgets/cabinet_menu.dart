import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/blocs/blocs.dart';
import 'package:helppay_web_app/routing/routes.gr.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

class CabinetMenu extends StatelessWidget {
  final int? selectedIndex;

  const CabinetMenu({required this.selectedIndex});

  @override
  Widget build(BuildContext context) => BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLogOutSuccess) {
            AutoRouter.of(context).push(
              AuthRoute(),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[300]!))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'HelpPay',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppStyles.cabinetMenuTextColor),
              ),
              //SvgPicture.asset('assets/images/logo.svg'),
              Row(
                children: [
                  CabinetMenuItem(
                    selected: selectedIndex == 0,
                    onTap: () => AutoRouter.of(context).pushAndPopUntil(
                        const MdomAccrualsRoute(),
                        predicate: (route) => false),
                    iconName: 'menu_payments',
                    text: context.t.mobileScreens.main.menu.accruals,
                  ),
                  CabinetMenuItem(
                    selected: selectedIndex == 1,
                    onTap: () => AutoRouter.of(context).pushAndPopUntil(
                        const ProductsRoute(),
                        predicate: (route) => false),
                    iconName: 'menu_accounts',
                    text: context.t.mobileScreens.main.menu.products,
                  ),
                  CabinetMenuItem(
                    selected: selectedIndex == 2,
                    onTap: () => AutoRouter.of(context).pushAndPopUntil(
                        const PaymentsHistoryRoute(),
                        predicate: (route) => false),
                    iconName: 'menu_history',
                    text: context.t.mobileScreens.main.menu.history,
                  ),
                ],
              ),
              Row(
                children: [
                  ProfileCabinetMenuItem(
                    onTap: () => AutoRouter.of(context).pushAndPopUntil(
                        const ProfileRoute(),
                        predicate: (route) => false),
                  ),
                  const CabinetReferenceWidget(),
                  ExitCabinetMenuItem()
                ],
              )
            ],
          ),
        ),
      );
}
