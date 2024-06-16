import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/injection_component.dart';
import 'package:helppay_web_app/screens/mdom_account_info/main_widgets/mdom_account_info_screen_body.dart';

@RoutePage()
class MdomAccountInfoScreen extends StatelessWidget {
  static const PageInfo<dynamic> routePage = PageInfo('/mdomAccountInfo');

  static const pageRoute = '/mdomAccountInfo';

  final PropertyAccount? account;
  final int? supplierId;
  final String? supplierTitle;

  const MdomAccountInfoScreen({
    Key? key,
    @PathParam('id') this.supplierId,
    @PathParam('title') this.supplierTitle,
    this.account,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _windowHistoryBack(context);
    return BlocProvider<MdomAccountInfoBloc>(
      create: (context) => MdomAccountInfoBloc(
          dataManager: InjectionComponent.getDependency<DataManager>(),
          supplierId: supplierId ?? 0,
          account: account?.account?.evalue ?? ''),
      child: MdomAccountInfoScreenBody(
          account: account ?? PropertyAccount(),
          supplierTitle: !(supplierTitle ?? '').contains('%')
              ? supplierTitle ?? ''
              : Uri.decodeComponent(supplierTitle ?? '')),
    );
  }

  Future<void> _windowHistoryBack(BuildContext context) async {
    if (account == null) {
      AutoRouter.of(context).back();
    }
  }
}
