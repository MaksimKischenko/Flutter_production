import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:payment_tracking_module/data/data.dart';

import 'widgets/widgets.dart';


@RoutePage<ArchiveLocation>()
class ArchiveLocationAddScreen extends StatelessWidget {

  static const pageRoute = '/archive_location_add';
  static const pageName = 'Добавление справочника локаций баз данных';
  
  const ArchiveLocationAddScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
    body: ArchiveLocationAddScreenBody(),
  );
}
