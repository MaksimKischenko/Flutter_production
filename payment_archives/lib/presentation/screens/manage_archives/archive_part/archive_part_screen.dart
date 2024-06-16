import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';

import 'widgets/widgets.dart';

@RoutePage()
class ArchivePartScreen extends StatelessWidget {
  static const String pageRoute = '/archive_part';


  final int? archiveID;

  const ArchivePartScreen({
    Key? key,
    @PathParam('id') this.archiveID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Row(
        children: [
          DrawerMenu(
            selectedIndex: 1,
            selecdedExpandedIndex: 0,
          ),        
          Expanded(
            child: BlocProvider<ArchivePartBloc>(
              create: (context) => ArchivePartBloc(
                id: archiveID ?? 0
              )..add(ArchivePartInit()),
              child: const ArchivePartScreenBody(),
            ),
          ),
        ],
      ),
    )
  );
}
