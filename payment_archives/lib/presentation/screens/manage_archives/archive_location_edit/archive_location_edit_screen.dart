import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';

import 'widgets/widgets.dart';

@RoutePage<ArchiveLocation>()
class ArchiveLocationEditScreen extends StatelessWidget {
  static const pageRoute = '/archive_location_edit';
  static const pageName = 'Редактирование справочника локаций баз данных';

  final int? archiveId;
  final ArchiveLocation? archiveLocation;

  const ArchiveLocationEditScreen({
    Key? key,
    @PathParam('id') this.archiveId,
    this.archiveLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: BlocProvider<ArchiveLocationUpdateBloc>(
      create: (context) => ArchiveLocationUpdateBloc(
        id:  archiveId ?? 0,
        archiveLocation: archiveLocation ?? ArchiveLocation.empty()            
      )..add(ArchiveLocationUpdateInit()),
      child: const ArchiveLocationEditScreenBody(),
    ),
  );
}
