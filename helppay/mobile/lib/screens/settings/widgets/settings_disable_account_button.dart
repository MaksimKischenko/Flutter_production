import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/injection_component.dart';
import 'package:helppay/utils/multiplatform.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets.dart';

class DeleteUserItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SettingsItem(
        onTap: () => _onTap(context),
        text: context.t.mobileScreens.settings.sections.deleteAccount.title,
        item: const Icon(Icons.delete_forever_rounded, color: Colors.red),
        // context.t.mobileScreens.settings.sections.account.changePassword
      );

  void _onTap(BuildContext context) {
    Multiplatform.showDecisionMessage(
      context: context,
      dialogTitle: context.t.mobileScreens.settings.sections.deleteAccount.text,
      message: '',
      action: () {
        BlocProvider.of<MdomDeleteBloc>(context).add(MdomDeleteAccount(login: InjectionComponent.getDependency<DataManager>().email ?? ''));   
      },
      buttonTitle: context.t.mobileScreens.settings.sections.deleteAccount.yes,
      cancelButtonTitle: context.t.mobileScreens.settings.sections.deleteAccount.no,
    );
  }
}
