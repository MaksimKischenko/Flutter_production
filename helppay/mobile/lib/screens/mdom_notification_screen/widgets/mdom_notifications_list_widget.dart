import 'package:flutter/material.dart';
import 'package:helppay/screens/mdom_notification_screen/widgets/widgets.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

class MdomNotificationWidget extends StatelessWidget {
  final List<ResponseNotification?> notifications;
  final String supplierTitle;

  const MdomNotificationWidget({
    required this.notifications,
    required this.supplierTitle,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (CoreConfig.appFlavour == AppFlavour.full)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
              child: PageTitle(
                text: context.t.mobileScreens.mdomNotificationsScreen.title,
              ),
            ),
          ...notifications
              .map((ResponseNotification? notification) => MdomNotificationItem(
                    notification: notification,
                    supplierTitle: supplierTitle,
                  ))
              .toList()
        ],
      );
}
