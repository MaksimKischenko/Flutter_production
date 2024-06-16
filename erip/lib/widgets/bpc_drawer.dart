import 'package:bpc_nkfo/blocs/blocs.dart';
import 'package:bpc_nkfo/data/data.dart';
import 'package:bpc_nkfo/injection_component.dart';
import 'package:bpc_nkfo/navigation.dart';
import 'package:bpc_nkfo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets.dart';

class BpcDrawer extends StatefulWidget {
  final bool isInfoSelected;
  final bool isClaimsSelected;
  final bool isPaymentsSelected;
  final bool isServicesQrSelected;
  final bool isHelpSelected;
  final bool isAboutSelected;
  final bool isSettingsSelected;

  const BpcDrawer({
    this.isInfoSelected = false,
    this.isClaimsSelected = false,
    this.isPaymentsSelected = false,
    this.isServicesQrSelected = false,
    this.isHelpSelected = false,
    this.isAboutSelected = false,
    this.isSettingsSelected = false
  });

  @override
  _BpcDrawerState createState() => _BpcDrawerState();
}

class _BpcDrawerState extends State<BpcDrawer> {
  late DataManager _dataManager;

  late String _navOrgText;
  late String _navUnpText;

  @override
  void initState() {
    _dataManager = InjectionComponent.getDependency<DataManager>();
    _navOrgText = _dataManager.informationResponse?.shortName ?? '';
    _navUnpText = _dataManager.informationResponse?.unp.toString() ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        BpcDrawerHeader(
          title: _navOrgText,
          subtitle: 'УНП $_navUnpText',
        ),
        DrawerItem(
          selected: widget.isInfoSelected,
          icon: Icons.assignment_ind,
          text: 'Информация',
          onTap: () {
            // Close the drawer.
            Navigator.pop(context);
            if (!widget.isInfoSelected) {
              Navigation.toHome();
            }
          }
        ),
        DrawerItem(
          selected: widget.isClaimsSelected,
          icon: Icons.list,
          text: 'Требования',
          onTap: () {
            // Close the drawer.
            Navigator.pop(context);
            if (!widget.isClaimsSelected) {
              Navigation.toClaims();
            }
          },
        ),
        DrawerItem(
          selected: widget.isPaymentsSelected,
          icon: Icons.monetization_on,
          text: 'Платежи',
          onTap: () {
            // Close the drawer.
            Navigator.pop(context);
            if (!widget.isPaymentsSelected) {
              Navigation.toPayments();
            }
          },
        ),
        DrawerItemSvg(
          selected: widget.isServicesQrSelected,
          assetName: 'QR',
          text: 'QR-коды услуг',
          onTap: () {
            // Close the drawer.
            Navigator.pop(context);
            if (!widget.isServicesQrSelected) {
              Navigation.toServicesQr();
            }
          },
        ),
        const Divider(),
        DrawerItem(
          selected: widget.isHelpSelected,
          icon: Icons.help_outline,
          text: 'Помощь',
          onTap: () {
            // Close the drawer.
            Navigator.pop(context);
            if (!widget.isHelpSelected) {
              Navigation.toInfo();
            }
          },
        ),
        DrawerItem(
          selected: widget.isSettingsSelected,
          icon: Icons.settings,
          text: 'Настройки',
          onTap: () {
            // Close the drawer.
            Navigator.pop(context);
            if (!widget.isSettingsSelected) {
              Navigation.toSettings();
            }
          },
        ),
        DrawerItem(
          selected: widget.isAboutSelected,
          icon: Icons.info_outline,
          text: 'О приложении',
          onTap: () {
            // Close the drawer.
            Navigator.pop(context);
            if (!widget.isAboutSelected) {
              Navigation.toAbout();
            }
          },
        ),
        DrawerItem(
          selected: false,
          icon: Icons.undo,
          text: 'Выйти из аккаунта',
          onTap: () async {
            Multiplatform.showDecisionMessage(
              context: context,
              message: _dataManager.isCredentialsSaveChecked ? 'Ваши авторизационные данные будут удалены с устройства' : null,
              action: () {
                BlocProvider.of<AuthBloc>(context).add(AuthLogOut());
              },
              dialogTitle: 'Уверены, что хотите выйти?',
              buttonTitle: 'Выйти',
              cancelButtonTitle: 'Остаться'
            );
          }
        )
      ]
    )
  );
  
}