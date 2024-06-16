import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class NotificationItem extends StatelessWidget {
  final String value;
  final Function(String value) onTap;
  final String? currentNotificationMethodName;

  const NotificationItem({
    Key? key,
    required this.value,
    required this.currentNotificationMethodName,
    required this.onTap,
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
          Container(
            decoration: BoxDecoration(
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
                color: AppStyles.mainTextColor.withOpacity(0.9)
              ),
            ),
          ),
        ],
      ),
    ),
  );
}