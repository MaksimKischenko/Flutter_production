import 'package:flutter/material.dart';
import 'package:isc_web_app/generated/translations.g.dart';
import 'package:isc_web_app/styles.dart';


class LanguagePicker extends StatelessWidget {
  final AppLocale currentLocale;
  final Function(AppLocale value) onChanged;
  const LanguagePicker({
    Key? key,
    required this.currentLocale,
    required this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    alignment: Alignment.center,
    child: DropdownButton<AppLocale>(
      value: currentLocale,
      onChanged: (value) {
        if (value != null && value != currentLocale) {
          onChanged(value);
        }
      },
      items: AppLocale.values.map((e) => DropdownMenuItem(
        value: e,
        child: Text(
          e.languageTag.toUpperCase(),
          style: TextStyle(
            color: AppStyles.mainColorDark,
            fontWeight: e == LocaleSettings.currentLocale
                ? FontWeight.bold
                : null
          ),
        ),
      )).toList(),
      selectedItemBuilder: (context) => AppLocale.values.map((e) => Container(
        // color: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        child: Text(
          e.languageTag.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
      )).toList(),
      style: const TextStyle(
        color: AppStyles.mainColorDark,
        // fontWeight: FontWeight.bold
      ),
      icon: const SizedBox.shrink(),
      underline: const SizedBox.shrink(),
    ),
  );
}