import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';

import 'widgets/widgets.dart';

@RoutePage<DataSource>()
class DataSourceEditScreen extends StatelessWidget {

  static const pageRoute = '/data_source_edit';
  static const pageName = 'Редактирование источника данных';

  final int? dataSourceId;
  final DataSource? dataSource;

  const DataSourceEditScreen({
    Key? key,
    @PathParam('id') this.dataSourceId,
    this.dataSource,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) => Scaffold(
    body: BlocProvider<DataSourceUpdateBloc>(
      create: (context) => DataSourceUpdateBloc(
        id:  dataSourceId ?? 0,
        dataSource: dataSource ?? DataSource.empty()
      )..add(DataSourceUpdateInit()),
      child: const DataSourceEditScreenBody() 
    ),
  );
}
