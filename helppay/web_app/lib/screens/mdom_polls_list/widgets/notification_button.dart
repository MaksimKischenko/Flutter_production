import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay_web_app/navigation.dart';

class NotificatioButton extends StatelessWidget {
  final int supplierId;
  final String? supplierTitle;
  final int notificationCount;
  const NotificatioButton({
    super.key,
    required this.notificationCount,
    required this.supplierId,
    this.supplierTitle,
  });

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          IconButton(
              onPressed: () => Navigation.toMdomNotificationList(
                    context: context,
                    supplierId: supplierId,
                    supplierTitle: supplierTitle ?? '',
                  ),
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
