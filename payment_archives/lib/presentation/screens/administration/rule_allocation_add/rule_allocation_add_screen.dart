import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:payment_tracking_module/data/data.dart';

import 'widgets/widgets.dart';




@RoutePage<RuleAllocationData>()
class RuleAllocationAddScreen extends StatelessWidget {

  static const pageRoute = '/rule_allocation_add';
  static const pageName = 'Добавление правила распределения архивов';

  const RuleAllocationAddScreen({
    Key? key,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) => const Scaffold(
      body: RuleAllocationsAddScreenBody(),
    );
}
