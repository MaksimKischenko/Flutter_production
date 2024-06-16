import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';

import 'widgets/widgets.dart';


@RoutePage<RuleAllocationData>()
class RuleAllocationEditScreen extends StatelessWidget {
  static const pageRoute = '/rule_allocation_edit';
  static const pageName = 'Редактирование правила распределения архивов';

  final int? ruleAllocationId;
  final RuleAllocationData? ruleAllocation;

  const RuleAllocationEditScreen({
    Key? key,
    @PathParam('id') this.ruleAllocationId,
    this.ruleAllocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>  Scaffold(
    body: BlocProvider<RuleAllocationUpdateBloc>(
      create: (context) => RuleAllocationUpdateBloc(
        id:  ruleAllocationId ?? 0,
        ruleAllocationData: ruleAllocation           
      )..add(RuleAllocationUpdateInit()),
      child: const RuleAllocationEditScreenBody(),
    ),
  );
}
