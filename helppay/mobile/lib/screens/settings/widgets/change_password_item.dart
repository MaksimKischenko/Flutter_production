import 'package:flutter/material.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets.dart';

class ChangePasswordItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SettingsItem(
    onTap: () => _onTap(context),
    text: context.t.mobileScreens.settings.sections.account.changePassword
  );

  void _onTap(BuildContext context) {
    Navigation.toChangePassword(context: context);
  }
}