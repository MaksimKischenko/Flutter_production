import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:helppay_web_app/screens/mdom_polls_list/main_widgets/polls_list_screen_body.dart';

@RoutePage()
class MdomPollsListScreen extends StatelessWidget {
  static const PageInfo<dynamic> routePage = PageInfo('/polls');

  static const pageRoute = '/polls';

  final int? supplierId;
  final int? accountsCount;
  final String? supplierTitle;

  const MdomPollsListScreen({
    @PathParam('id') this.supplierId,
    @PathParam('count') this.accountsCount,
    @PathParam('title') this.supplierTitle,
  });

  @override
  Widget build(BuildContext context) => MdomPollsListScreenBody(
        supplierId: supplierId ?? 0,
        accountsCount: accountsCount ?? 0,
        supplierTitle: !(supplierTitle ?? '').contains('%')
            ? supplierTitle ?? ''
            : Uri.decodeComponent(supplierTitle ?? ''),
      );
}
