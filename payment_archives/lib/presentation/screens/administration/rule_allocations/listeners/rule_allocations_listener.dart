import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/utils/utils.dart';

mixin RuleAllocationsListener {
  static void fromActions(
    BuildContext context,
    RuleAllocationState state,
    Function() outAction
  ) {
    if (state is RuleAllocationsDeleteRuleAllocationSuccess) {
      DialogPlatform.showMessage(
        context: context,
        title: 'Успешно',
        message: 'Правило распределение архивов удалено',
        type: DialogType.success
      );
      _resetSelection(context); 
    } else if(state is RuleAllocationsAddRuleAllocationSuccess) {
        DialogPlatform.showMessage(
          context: context,
          title: 'Успешно',
          message: 'Правило распределение архивов добавлено',
          type: DialogType.success
        );  
      _resetSelection(context);  
    } else if(state is RuleAllocationsEditRuleAllocationSuccess) {
        DialogPlatform.showMessage(
          context: context,
          title: 'Успешно',
          message: 'Правило распределение архивов отредактировано',
          type: DialogType.success
        );  
    } else if(state is RuleAllocationError) {
      RequestUtil.catchNetworkError(
        context: context,
        obj: state.error
      ); 
      _resetSelection(context);                        
    }      
  }

   static void _resetSelection(BuildContext context) {
    context.read<RowSelectedBloc<RuleAllocationData>>().
      add(RowSelectedRun(selectedData: SelectedData.empty())
    );     
  }    
}