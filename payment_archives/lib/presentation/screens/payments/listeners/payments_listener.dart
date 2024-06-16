import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/utils/utils.dart';

mixin PaymentsListener {
  static void fromPaymentsActions(
    BuildContext context,
    SearchPaymentState state,
  ) {
    if(state is SearchPaymentPartLoaded) {
      if(state.nextLoadedPayments.isNotEmpty) {
        DialogPlatform.showSnackBar(
          type: DialogType.success,
          context: context, 
          message: 'Платежи загружены: кол-во: ${state.nextLoadedPayments.length}'
        );
      } else {
        DialogPlatform.showSnackBar(
          type: DialogType.info,
          context: context, 
          message: 'Платежей по данным критериям отбора нет'
        );              
      }          
    } else if (state is SearchPaymentNetworkError) {
      RequestUtil.catchNetworkError(
        context: context,
        obj: state.error,
      );    
      _refreshDataFiltersAndSelects(context);                               
    }  
  }

  static void fromWebSocketsActions(
    BuildContext context,
    WebSocketState state,
  ) {
    if (state is WebSocketLoadedInfo) {
      context.read<SearchPaymentBloc>().add(SearchPaymentRun(webSocketData: state.webSocketData));            
    } else if (state is WebSocketError) {
      RequestUtil.catchNetworkError(
        context: context,
        obj: state.error
      );                       
      _refreshDataFiltersAndSelects(context);    
    } 
  }  

  static void uiFormReportsActions(
    BuildContext context,
    FormReportsState state,
  ) {
    if (state is FormReportsError) {
      RequestUtil.catchNetworkError(
        context: context,
        obj: state.error
      );                       
    } 
  }   

  static void _refreshDataFiltersAndSelects(BuildContext context) {
    BlocProvider.of<RowSelectedBloc<List<Payment>>>(context).add(RowSelectedRun<List<Payment>>(
      selectedData: SelectedData<List<Payment>>(isSelected: false, selectedObject: [])));
    context.read<SearchPaymentBloc>().add(SearchPaymentClearData());
  }
}