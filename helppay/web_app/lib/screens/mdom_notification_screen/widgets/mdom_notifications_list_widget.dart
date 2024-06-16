import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';

class MdomNotificationWidget extends StatelessWidget {
  final List<ResponseNotification?> notifications;
  final String supplierTitle;
  final void Function(int) onLoadMorePulled;

  const MdomNotificationWidget({
    required this.notifications,
    required this.supplierTitle,
    required this.onLoadMorePulled,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...notifications
              .map(
                (ResponseNotification? notification) => Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 40),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.black),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(43, 80, 161, 0.06),
                          blurRadius: 25,
                          // offset:  Offset(2, .2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if ((notification?.status ?? 1) == 2)
                                Row(
                                  children: [
                                    const Icon(Icons.check,
                                        size: 14, color: Color(0xff05BF65)),
                                    const SizedBox(width: 6),
                                    Text(
                                      context
                                          .t
                                          .mobileScreens
                                          .mdomNotificationsScreen
                                          .successModal
                                          .title,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff05BF65),
                                      ),
                                    ),
                                  ],
                                ),
                              const SizedBox(height: 8),
                              Text(
                                supplierTitle,
                                style: TextStyle(
                                  color:
                                      const Color(0xff303246).withOpacity(0.5),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                notification?.message ?? '',
                                style: const TextStyle(
                                  color: Color(0xff303246),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                          if ((notification?.status ?? 1) != 2)
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: const Color(0xffFF5454),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                child: Text(
                                  context.t.mobileScreens
                                      .mdomNotificationsScreen.readButton,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
          const SizedBox(height: 6),
          Center(
            child: GestureDetector(
              onTap: () => onLoadMorePulled(notifications.length),
              child: Text(
                  context.t.mobileScreens.mdomNotificationsScreen.loadMore),
            ),
          )
        ],
      );
}
