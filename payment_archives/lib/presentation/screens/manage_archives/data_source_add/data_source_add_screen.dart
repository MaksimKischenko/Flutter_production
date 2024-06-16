import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:payment_tracking_module/data/data.dart';

import 'widgets/widgets.dart';




@RoutePage<DataSource>()
class DataSourceAddScreen extends StatelessWidget {

  static const pageRoute = '/data_source_add';
  static const pageName = 'Добавление источника данных';

  @override
  Widget build(BuildContext context) => Scaffold(
    body: DataSourceAddScreenBody(),
  );
}
