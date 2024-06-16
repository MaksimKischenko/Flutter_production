import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/utils/utils.dart';

mixin UsersListener {
  static void fromActions(
    BuildContext context,
    UsersState state,
    Function() outAction
  ) {
    if (state is UsersDeleteUserSuccess) {
      DialogPlatform.showMessage(
        context: context,
        title: 'Успешно',
        message: 'Пользователь удален',
        type: DialogType.success
      );
      _resetSelection(context);
    } else if(state is UsersAddUserSuccess) {
        DialogPlatform.showMessage(
          context: context,
          title: 'Успешно',
          message: 'Пользователь добавлен',
          type: DialogType.success
        );  
        _resetSelection(context); 
    } else if(state is UsersEditUserSuccess) {
        DialogPlatform.showMessage(
          context: context,
          title: 'Успешно',
          message: 'Пользователь отредактирован',
          type: DialogType.success
        );   
        _resetSelection(context);                 
    } else if(state is UsersError) {
      RequestUtil.catchNetworkError(
        context: context,
        obj: state.error
      );   
      _resetSelection(context);                      
    }        
  }

   static void _resetSelection(BuildContext context) {
    context.read<RowSelectedBloc<User>>().
      add(RowSelectedRun(selectedData: SelectedData.empty())
    );  
  }    
}