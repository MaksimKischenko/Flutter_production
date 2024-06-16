
import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class ChangeNotificationMethodItem extends StatelessWidget {
  final Function() onTap;
  final String notificationMethodName;

  const ChangeNotificationMethodItem({
    Key? key,
    required this.onTap,
    required this.notificationMethodName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              context.t.mobileScreens.settings.sections.account.notification,
              style: const TextStyle(
                color: Color(0xff383A51),
                fontSize: 18
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            notificationMethodName,
            style: const TextStyle(
              color: AppStyles.mainColorDark,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    ),
  );
}