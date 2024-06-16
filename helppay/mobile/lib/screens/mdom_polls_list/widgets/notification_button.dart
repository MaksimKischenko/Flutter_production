import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay_core/utils/utils.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'notfication_button');

class NotificatioButton extends StatelessWidget {
  final int notificationCount;
  final VoidCallback onNotificationsTap;
  const NotificatioButton({
    super.key,
    required this.notificationCount,
    required this.onNotificationsTap,
  });

  @override
  Widget build(BuildContext context) {
    _log('notification count $notificationCount');
    return Stack(
      children: <Widget>[
        IconButton(
            onPressed: onNotificationsTap,
            icon: SvgPicture.asset(
                'assets/icon/mdom_accruals_notifications_icon.svg')),
        if (notificationCount != 0)
          Positioned(
            right: 11,
            top: 11,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: const BoxConstraints(
                minWidth: 14,
                minHeight: 14,
              ),
              child: Text(
                '$notificationCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
