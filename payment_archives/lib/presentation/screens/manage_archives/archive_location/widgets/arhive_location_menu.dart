import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/routing/routes.gr.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';
import 'package:payment_tracking_module/utils/utils.dart';

class ArchiveLocationMenu extends StatelessWidget {

  final bool isSelected;
  final ArchiveLocation? archiveLocation;

  const ArchiveLocationMenu({
    required this.isSelected,
    required this.archiveLocation,
    super.key
  });

  @override
  Widget build(BuildContext context) => Row(
    children: [
      ChangeGolorButton(
        name: ButtonNames.add.message,
        onTap: () async => _toArchiveLocationAddScreen(context)       
      ),
      const SizedBox(width: 8),
      SimpleButton(
        isActive: isSelected,
        name: ButtonNames.edit.message,
        onTap: () async => _toArchiveLocationEditScreen(context)
      ),
      SimpleButton(
        isActive: isSelected,
        name: ButtonNames.delete.message,
        onTap: () => _archiveLocationDelete(context)
      ),
    ],
  );


 Future<void> _toArchiveLocationAddScreen(BuildContext context) async {

   final _archiveLocation =  await AutoRouter.of(context).push<ArchiveLocation>(
      const ArchiveLocationAddRoute()
   );

    if(_archiveLocation != null) {
      context.read<ArchiveLocationBloc>().add(NewArchiveLocationUpdateTable(newArchiveLocation: _archiveLocation));
    }
 }

  Future<void> _toArchiveLocationEditScreen(BuildContext context) async {
    final _archiveLocation =  await AutoRouter.of(context).push<ArchiveLocation>(
      ArchiveLocationEditRoute(
        archiveLocation: archiveLocation,
        archiveId: archiveLocation?.id ?? 0
      )
    );
    if(_archiveLocation != null) {
      context.read<ArchiveLocationBloc>().add(EditedArchiveLocationUpdateTable(_archiveLocation));    
    }
  }

  Future<void> _archiveLocationDelete(BuildContext context) async {
    DialogPlatform.showDecisionMessage(
      context: context,
      message: '',
      action: () => context.read<ArchiveLocationBloc>().add(ArchiveLocationsDeleteArchiveLocation(archiveLocation?.id ?? 0)),
      dialogTitle: 'Уверены, что хотите удалить\ncправочник локаций баз данных?',
      buttonTitle: 'Удалить',
      cancelButtonTitle: 'Нет'
    );      
  }
}
