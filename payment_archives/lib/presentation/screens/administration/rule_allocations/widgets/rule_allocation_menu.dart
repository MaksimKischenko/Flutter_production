import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/routing/routes.gr.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';
import 'package:payment_tracking_module/utils/utils.dart';

class RuleAllocationMenu extends StatelessWidget {

  final bool isSelected;
  final RuleAllocationData? ruleAllocation;

  const RuleAllocationMenu({
    required this.isSelected,
    required this.ruleAllocation,
    super.key
  });

  @override
  Widget build(BuildContext context) => Row(
    children: [
      ChangeGolorButton(
        name: ButtonNames.add.message,
        onTap: () async => _toRuleAllocationAddScreen(context)       
      ),
      const SizedBox(width: 8),
      SimpleButton(
        isActive: isSelected,
        name: ButtonNames.edit.message,
        onTap: () async => _toRuleAllocationEditScreen(context)
      ),
      SimpleButton(
        isActive: isSelected,
        name: ButtonNames.delete.message,
        onTap: () async => _ruleAllocationDelete(context)
      ),
    ],
  );


 Future<void> _toRuleAllocationAddScreen(BuildContext context) async {

   final _ruleAllocationData =  await AutoRouter.of(context).push<RuleAllocationData>(
      const RuleAllocationAddRoute()
   );

    if(_ruleAllocationData != null) {
      context.read<RuleAllocationBloc>().add(NewRoleAllocationUpdatedTable(ruleAllocation: _ruleAllocationData)); 
    }
 }

  Future<void> _toRuleAllocationEditScreen(BuildContext context) async {
    final _ruleAllocationData =  await AutoRouter.of(context).push<RuleAllocationData>(
      RuleAllocationEditRoute(
        ruleAllocationId: ruleAllocation?.id ?? 0,
        ruleAllocation: ruleAllocation
      )
    );
    if(_ruleAllocationData != null) {
      context.read<RuleAllocationBloc>().add(EditedRuleAllocationUpdateTable(_ruleAllocationData));    
    }
  }

  Future<void> _ruleAllocationDelete(BuildContext context) async {
    DialogPlatform.showDecisionMessage(
      context: context,
      message: '',
      action: () =>
          context.read<RuleAllocationBloc>().add(RuleAllocationsDeleteRuleAllocation(ruleAllocation?.id ?? 0)),
      dialogTitle: 'Уверены, что хотите удалить правила распределения архивов?',
      buttonTitle: 'Удалить',
      cancelButtonTitle: 'Нет');
  }
}

