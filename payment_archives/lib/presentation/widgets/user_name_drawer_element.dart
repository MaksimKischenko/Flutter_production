import 'package:flutter/material.dart';

import 'package:payment_tracking_module/data/data_manager.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/styles.dart';

class UserNameDrawerElement extends StatelessWidget {

  final DataManager dataManager;

  const UserNameDrawerElement({
    Key? key,
    required this.dataManager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
    children:  [
      Container(
        width: 24,
        height: 24,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppStyles.colorBlue2,
          shape: BoxShape.circle
        ),
        child: const Icon(Icons.person, size: 16, color: AppStyles.colorWhite3),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Text(
          userRole(dataManager),
          style: AppStyles.textStyleWhiteNavigationButton
        )
      )                           
    ],
  );

  String userRole(DataManager dataManager) {
    switch (dataManager.tokendata?.userType) {
      case UserTypeRoleById.admin:
        return 'Администратор АП: ${dataManager.tokendata?.userName}';
      case UserTypeRoleById.user:
        return 'Пользователь АП: ${dataManager.tokendata?.userName}';
      case UserTypeRoleById.userViewer:
        return 'Участник просмотра пользователей АП: ${dataManager.tokendata?.userName}';
      default:
        return '';
    }
  }
}
