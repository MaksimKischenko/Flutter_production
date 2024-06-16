import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isc_web_app/generated/translations.g.dart';
import 'package:isc_web_app/routing/routes.gr.dart';
import 'package:isc_web_app/styles.dart';
import 'package:isc_web_app/widgets/widgets.dart';

class CabinetMenu extends StatelessWidget {
  final int? selectedIndex;

  const CabinetMenu({required this.selectedIndex});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[300]!))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Система выставления счетов и платежей',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppStyles.cabinetMenuTextColor
              ),
            ),
            //SvgPicture.asset('assets/images/logo.svg'),
            Row(
              children: [                               
                CabinetMenuItem(
                  selected: selectedIndex == 1,
                  onTap: () => AutoRouter.of(context).pushAndPopUntil(
                      const ClaimsRoute(),
                      predicate: (route) => false),
                  icon: CupertinoIcons.doc_plaintext,
                  text: context.t.mobileScreens.main.menu.claims,
                ),     
                CabinetMenuItem(
                  selected: selectedIndex == 2,
                  onTap: () => AutoRouter.of(context).pushAndPopUntil(
                      const PaymentsISCRoute(),
                      predicate: (route) => false),
                  icon: Icons.payments_outlined,
                  text: context.t.mobileScreens.main.menu.payments,
                ),                             
              ],
            ),
            Row(
              children: [
                CabinetMenuItem(
                  selected: selectedIndex == 5,
                  onTap: () => AutoRouter.of(context).pushAndPopUntil(
                      const ProfileRoute(),
                      predicate: (route) => false
                  ),
                  icon: CupertinoIcons.person,
                  text: 'Профиль',
                ),
                CabinetMenuItem(
                  selected: selectedIndex == 6,
                  onTap: () => AutoRouter.of(context).pushAndPopUntil(
                      const SettingsRoute(),
                      predicate: (route) => false
                  ),
                  icon: CupertinoIcons.settings,
                  text: 'Настройки',
                ),                
                //const CabinetReferenceWidget(),
                ExitCabinetMenuItem()
              ],
            )
          ],
        ),
      );
}
