import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/utils/utils.dart';

mixin DataSourceDirListener {
  static void fromActions(
    BuildContext context,
    DataSourceState state,
    Function() outAction
  ) {
    if (state is DataSourcesDeleteDataSourceSuccess) {
      DialogPlatform.showMessage(
        context: context,
        title: 'Успешно',
        message: 'Источник данных ${state.id} удален',
        type: DialogType.success
      );
      _resetSelection(context);      
    } else if(state is DataSourcesAddDataSourceSuccess) {
        DialogPlatform.showMessage(
          context: context,
          title: 'Успешно',
          message: 'Источник данных добавлен',
          type: DialogType.success
        );  
      _resetSelection(context);        
    } else if(state is DataSourcesEditDataSourceSuccess) {
        DialogPlatform.showMessage(
          context: context,
          title: 'Успешно',
          message: 'Источник данных отредактирован',
          type: DialogType.success
        ); 
      _resetSelection(context);                          
    } else if(state is DataSourceError) {
      RequestUtil.catchNetworkError(
        context: context,
        obj: state.error
      ); 
      _resetSelection(context);        
    }        
  }

   static void _resetSelection(BuildContext context) {
    context.read<RowSelectedBloc<DataSource>>().
      add(RowSelectedRun(selectedData: SelectedData.empty())
    );  
  }    
}