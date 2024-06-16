import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';

import 'widgets/widgets.dart';


@RoutePage()
class ArchivesDirectoryScreen extends StatelessWidget {
  static const String pageRoute = '/arch_dir';

  const ArchivesDirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
  body: SafeArea(
    child: Row(
      children: [
        DrawerMenu(
          selectedIndex: 1,
          selecdedExpandedIndex: 0,
        ),
          BlocProvider(
            create: (context) => RowSelectedBloc<ArchiveDB>(),
            child: const Expanded(
              child: ArchivesDirectoryScreenBody()
            ),
         ),
      ],
    ),
  ));
}
