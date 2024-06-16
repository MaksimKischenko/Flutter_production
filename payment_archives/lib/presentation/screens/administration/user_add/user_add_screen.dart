
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:payment_tracking_module/data/data.dart';

import 'widgets/widgets.dart';


@RoutePage<User>()
class UserAddScreen extends StatelessWidget {

  static const pageRoute = '/user_add';
  static const pageName = 'Добавление пользователя';

  final int? selectedTypeId;

  const UserAddScreen({
    Key? key,
    this.selectedTypeId,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) => Scaffold(
    body: UserAddScreenBody(
      selectedTypeId: selectedTypeId ?? -1,
    ),
  );
}
