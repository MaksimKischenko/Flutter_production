import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';

import 'widgets/widgets.dart';

@RoutePage()
class AvailableArchiveLocationScreen extends StatelessWidget {
  static const String pageRoute = '/available_archive_location';

  final int? sourceId;

  const AvailableArchiveLocationScreen({
    Key? key,
    @PathParam('source_id') this.sourceId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Row(
        children: [
          DrawerMenu(
            selectedIndex: 1,
            selecdedExpandedIndex: 1,
          ),          
          Expanded(
            child: BlocProvider<AvailableArchiveLocationBloc>(
              create: (context) => AvailableArchiveLocationBloc(
                sourceId: sourceId ?? 0
              )..add(AvailableArchiveLocationInit()),
              child: const AvailableArchiveLocationScreenBody(),
            ),
          ),
        ],
      ),
    ),
  );
}
