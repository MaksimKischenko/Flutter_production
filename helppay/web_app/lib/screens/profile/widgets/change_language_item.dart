import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

class ChangeLanguageItem extends StatelessWidget {
  final Function() onTap;

  const ChangeLanguageItem({
    Key? key,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Padding(
      // padding: const EdgeInsets.all(16),
      padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              context.t.mobileScreens.settings.sections.account.language,
              style: const TextStyle(
                color: Color(0xff383A51),
                fontSize: 18
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            LocaleSettings.currentLocale.languageTag.toUpperCase(),
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