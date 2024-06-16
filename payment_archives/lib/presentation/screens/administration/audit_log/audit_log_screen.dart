import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';

import 'widgets/widgets.dart';

@RoutePage()
class AuditLogScreen extends StatelessWidget {
  static const String pageRoute = '/audit_log';

  const AuditLogScreen({super.key});


  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,            
        children: [
          DrawerMenu(
            selectedIndex: 0,
            selecdedExpandedIndex: 0,
          ),
          const Expanded(child: AuditLogScreenBody())   
        ],
      ),
    ),     
  );
}
