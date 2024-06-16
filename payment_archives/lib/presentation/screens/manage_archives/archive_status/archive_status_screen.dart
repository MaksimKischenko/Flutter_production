import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';

import 'widgets/widgets.dart';


@RoutePage()
class ArchiveStatusScreen extends StatelessWidget {
  static const String pageRoute = '/archive_status';
  
  const ArchiveStatusScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Row(
        children: [
          DrawerMenu(
            selectedIndex: 1,
            selecdedExpandedIndex: 3,
          ),    
          const Expanded(
            child: ArchiveStatusScreenBody()
          ),
        ],
      )
    ),
  );
}
