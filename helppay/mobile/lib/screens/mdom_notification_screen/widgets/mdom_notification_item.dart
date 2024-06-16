import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';

class MdomNotificationItem extends StatelessWidget {
  final ResponseNotification? notification;
  final String supplierTitle;
  const MdomNotificationItem({
    super.key,
    required this.notification,
    required this.supplierTitle,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: GestureDetector(
          onTap: () => showDialog<void>(
            context: context,
            builder: (BuildContext context) => Center(
              child: Container(
                margin: const EdgeInsets.only(top: 33),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 280),
                  child: SizedBox(
                    width: 100,
                    child: Material(
                      color: Colors.white,
                      elevation: 24,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      type: MaterialType.card,
                      clipBehavior: Clip.none,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 2.7,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Center(
                                  child: Text(
                                    supplierTitle,
                                    style: const TextStyle(
                                      color: Color(0xff303246),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                notification?.topic ?? '',
                                // textAlign: TextAlign.start,
                                style: TextStyle(
                                  color:
                                      const Color(0xff303246).withOpacity(0.5),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'по ${notification!.stopDate}',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color:
                                      const Color(0xff303246).withOpacity(0.5),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 4),
                              SingleChildScrollView(
                                child: Text(notification?.message ?? ''),
                              )
                              // SizedBox(
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if ((notification?.status ?? 1) == 2)
                          Row(
                            children: [
                              const Icon(Icons.check,
                                  size: 14, color: Color(0xff05BF65)),
                              const SizedBox(width: 6),
                              Text(
                                context.t.mobileScreens.mdomNotificationsScreen
                                    .successModal.title,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff05BF65),
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 4),
                        Text(
                          supplierTitle,
                          style: TextStyle(
                            color: const Color(0xff303246).withOpacity(0.5),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                notification?.topic ?? '',
                                style: TextStyle(
                                  color:
                                      const Color(0xff303246).withOpacity(0.5),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'по ${notification!.stopDate}',
                                style: TextStyle(
                                  color:
                                      const Color(0xff303246).withOpacity(0.5),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          notification?.message ?? '',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xff303246),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
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
                          context.t.mobileScreens.mdomNotificationsScreen
                              .readButton,
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
      );
}
