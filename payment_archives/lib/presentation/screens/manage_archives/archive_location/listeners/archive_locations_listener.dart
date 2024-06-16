import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/utils/utils.dart';

mixin ArchiveLocationsListener {
  static void fromActions(
    BuildContext context,
    ArchiveLocationState state,
    Function() outAction
  ) {
    if (state is ArchiveLocationsDeleteArchiveLocationSuccess) {
      DialogPlatform.showMessage(
        context: context,
        title: 'Успешно',
        message: 'Справочник локаций баз данных удален',
        type: DialogType.success
      );  
      _resetSelection(context);
    } else if(state is ArchiveLocationsAddArchiveLocationSuccess) {
        DialogPlatform.showMessage(
          context: context,
          title: 'Успешно',
          message: 'Справочник локаций баз данных добавлен',
          type: DialogType.success
        ); 
      _resetSelection(context);     
    } else if(state is ArchiveLocationsEditArchiveLocationSuccess) {
        DialogPlatform.showMessage(
          context: context,
          title: 'Успешно',
          message: 'Справочник локаций баз данных отредактирован',
          type: DialogType.success
        );  
      _resetSelection(context);                       
    } else if(state is ArchiveLocationError) {
      RequestUtil.catchNetworkError(
        context: context,
        obj: state.error
      );  
      _resetSelection(context);                    
    }         
  }

   static void _resetSelection(BuildContext context) {
    context.read<RowSelectedBloc<ArchiveLocation>>().
      add(RowSelectedRun(selectedData: SelectedData.empty())
    );  
  }    
}