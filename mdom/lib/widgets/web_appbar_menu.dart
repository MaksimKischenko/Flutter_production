import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/features/features_bloc.dart';
import 'package:bpc/data/routing/routes.gr.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/widgets/exit_cabinet_item.dart';
import 'package:bpc/widgets/web_appbar_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WebCabinetMenu extends StatelessWidget {
  final int? selectedIndex;

  const WebCabinetMenu({this.selectedIndex});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Мой дом',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppStyles.mainTextColor,
              ),
            ),
            // SvgPicture.asset('assets/images/logo.svg'),
            Row(
              children: [
                AppbarWebMenuItem(
                    selected: selectedIndex == 0,
                    onTap: () => AutoRouter.of(context).pushAndPopUntil(
                        const ClaimsRoute(),
                        predicate: (route) => false),
                    iconName: 'menu_claims',
                    text: 'Требования'
                    // context.t.mobileScreens.main.menu.accruals,
                    ),
                AppbarWebMenuItem(
                  selected: selectedIndex == 1,
                  onTap: () => AutoRouter.of(context).pushAndPopUntil(
                      const PaymentsRoute(),
                      predicate: (route) => false),
                  iconName: 'menu_payments',
                  text: 'Платежи',
                  // context.t.mobileScreens.main.menu.products,
                ),
                AppbarWebMenuItem(
                  selected: selectedIndex == 2,
                  onTap: () => AutoRouter.of(context).pushAndPopUntil(
                      const ServicesQrRoute(),
                      predicate: (route) => false),
                  iconName: 'menu_qr',
                  text: 'Qr-коды услуг',
                  //  context.t.mobileScreens.main.menu.history,
                ),
                AppbarWebMenuItem(
                  selected: selectedIndex == 3,
                  onTap: () => AutoRouter.of(context).pushAndPopUntil(
                      const PollsListRoute(),
                      predicate: (route) => false),
                  iconName: 'menu_polls',
                  text: 'Голосования',
                  // context.t.mobileScreens.main.menu.history,
                ),
              ],
            ),
            Row(
              children: [
                BlocBuilder<FeaturesBloc, FeaturesState>(
                  builder: (context, state) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: GestureDetector(
                      onTap: () => AutoRouter.of(context).pushAndPopUntil(
                        const FeaturesRoute(),
                        predicate: (route) => false,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (state.organizationTitle != null)
                            Text(
                              state.organizationTitle!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.20,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          if (state.organizationUnp != null)
                            Text(
                              'УНП ${state.organizationUnp}',
                              style: TextStyle(
                                fontSize: 10,
                                // fontWeight: FontWeight.w400,
                                letterSpacing: 0.18,
                                color: AppStyles.mainTextColor.withOpacity(.5),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                // ProfileCabinetMenuItem(
                //   onTap: ()=>  AutoRouter.of(context).pushAndPopUntil(const ProfileRoute(), predicate: (route) => false),
                // ),
                ExitCabinetMenuItem()
              ],
            )
          ],
        ),
      );
}
