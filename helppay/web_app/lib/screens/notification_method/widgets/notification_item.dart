// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

class NotificationItem extends StatelessWidget {
  final String value;
  final Function(String value) onTap;
  final String? currentNotificationMethodName;

  const NotificationItem({
    Key? key,
    required this.value,
    required this.onTap,
    required this.currentNotificationMethodName,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) => InkWell(
    onTap: value != currentNotificationMethodName
        ? () => onTap(value)
        : null,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppStyles.mainColorDark,
                fontSize: 16,
              ),
            ),
          ),
          if (value == currentNotificationMethodName)
          // if (false)
          Container(
            decoration: BoxDecoration(
              // color: const Color(0xffF4F4F4),
              color: const Color.fromARGB(255, 118, 226, 145),
              borderRadius: BorderRadius.circular(16)
            ),
            margin: const EdgeInsets.only(left: 8),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Text(
              context.t.mobileScreens.selectLanguage.currentLanguageLabel.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 10,
                // color: Colors.white
                color: AppStyles.mainTextColor.withOpacity(0.9)
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
