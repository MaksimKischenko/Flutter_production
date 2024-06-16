import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/routing/routes.gr.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';
import 'package:payment_tracking_module/utils/utils.dart';

class DataSourceDirMenu extends StatelessWidget {

  final bool isSelected;
  final DataSource? dataSource;

  const DataSourceDirMenu({
    required this.isSelected,
    required this.dataSource,
    super.key
  });

  @override
  Widget build(BuildContext context) => Row(
    children: [
      ChangeGolorButton(
        name: ButtonNames.add.message,
        onTap: () async => _toDataSourceAddScreen(context)      
      ),
      const SizedBox(width: 8),   
      SimpleButton(
        isActive: isSelected,
        name: ButtonNames.edit.message,
        onTap: () async =>  _toDataSourceEditScreen(context)
      ),    
      SimpleButton(
        isActive: isSelected,
        name: ButtonNames.delete.message,
        onTap: () async => _dataSourceDelete(context)  
      ),             
      SimpleButton(
        isActive: isSelected,
        name: ButtonNames.availableLocations.message,
        onTap: () async => _toAvailableLocations(context)       
      ),
    ],
  );


  Future<void> _toAvailableLocations(BuildContext context) async {
   await AutoRouter.of(context).push(
      AvailableArchiveLocationRoute(
        sourceId: dataSource?.id ?? 0
      )
    );
  }

  Future<void> _toDataSourceAddScreen(BuildContext context) async {
    final _dataSource = await AutoRouter.of(context).push<DataSource>(const DataSourceAddRoute());

    if (_dataSource != null) {
      context.read<DataSourceBloc>().add(NewDataSourceUpdateTable(dataSource: _dataSource));
    }
  }

  Future<void> _toDataSourceEditScreen(BuildContext context) async {
    final _dataSource = await AutoRouter.of(context).push<DataSource>(DataSourceEditRoute(dataSource: dataSource, dataSourceId: dataSource?.id ?? 0));
    if (_dataSource != null) {
      context.read<DataSourceBloc>().add(EditedDataSourceUpdateTable(_dataSource));
    }
  }

  Future<void> _dataSourceDelete(BuildContext context) async {
    DialogPlatform.showDecisionMessage(
        context: context,
        message: '',
        action: () => context.read<DataSourceBloc>().add(DataSourcesDeleteDataSource(dataSource?.id ?? 0)),
        dialogTitle: 'Уверены, что хотите удалить источник данных?',
        buttonTitle: 'Удалить',
        cancelButtonTitle: 'Нет');
  }
}