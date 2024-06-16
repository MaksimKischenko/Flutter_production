import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/routing/routes.gr.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';

class ArchivesDBMenu extends StatelessWidget {

  final bool isSelected;
  final ArchiveDB? archiveDB;

  const ArchivesDBMenu({
    required this.isSelected,
    required this.archiveDB,
    super.key
  });

  @override
  Widget build(BuildContext context) => Row(
    children: [
      SimpleButton(
        isActive: isSelected,
        name: ButtonNames.archPart.message,
        onTap: () => _toArchDBPartScreen(context)
      ),
      const SizedBox(width: 8),      
      SimpleButton(
        isActive: isSelected,
        name: ButtonNames.mapAllocationArch.message,
        onTap: () => _toMapAllocationArchScreen(context)
      ),             
    ],
  );


 Future<void> _toArchDBPartScreen(BuildContext context) async {
   await AutoRouter.of(context).push(
      ArchivePartRoute(
        archiveID: archiveDB?.id ?? 0
      )
    );
  }

 Future<void> _toMapAllocationArchScreen(BuildContext context) async {
   await AutoRouter.of(context).push(
      MapAllocationRoute(
        archiveID: archiveDB?.id ?? 0
      )
    );
  }  
}