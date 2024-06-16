import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

class LanguageItem extends StatelessWidget {
  final AppLocale value;
  final Function(AppLocale value) onTap;

  const LanguageItem({
    Key? key,
    required this.value,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: value != LocaleSettings.currentLocale
        ? () => onTap(value)
        : null,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              value.languageTag.toUpperCase(),
              style: const TextStyle(
                color: AppStyles.mainColorDark,
                fontSize: 16,
              ),
            ),
          ),
          if (value == LocaleSettings.currentLocale)
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