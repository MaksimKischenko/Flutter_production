import 'package:flutter/material.dart';
import 'package:payment_tracking_module/data/data.dart';

import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/styles.dart';

class UsersActionPopUp extends StatelessWidget {
  final Function() onBlock;
  final Function() onReset;
  final User user;

  const UsersActionPopUp({
    Key? key,
    required this.onBlock,
    required this.onReset,
    required this.user
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => PopupMenuButton<UserActionType>(
    onSelected: (value) {
       switch (value) {
        case UserActionType.block:
          onBlock.call();
          break;
        case UserActionType.resetPassword:
        onReset.call();
        break;
      }
    },
    itemBuilder: (BuildContext context) => UserActionType.values.map<PopupMenuItem<UserActionType>>((action) 
    => PopupMenuItem<UserActionType>(
      value: action,
      child: Text(
        action.name(blocked: user.blocked ?? false),
        style: AppStyles.tableDataTextStyle,
      ),
    )).toList(),
    child: const Icon(
      Icons.more_horiz_rounded,
      size: 14,
      color: AppStyles.colorDark2,
    ),
  );
}
