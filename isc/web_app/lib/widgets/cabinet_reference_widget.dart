import 'dart:html';

import 'package:flutter/material.dart';
import 'package:isc_web_app/generated/translations.g.dart';
import 'package:isc_web_app/styles.dart';

class CabinetReferenceWidget extends StatelessWidget {
  const CabinetReferenceWidget({super.key});

  @override
  Widget build(BuildContext context) => TextButton(
            onPressed: () {}, //_downloadFile('assets/assets/guides/HelpPay.pdf'),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(const Color(0xffEDF6FF))
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Icon(
                    Icons.article_outlined,
                    color: AppStyles.cabinetMenuTextColor.withAlpha(225),
                  ),
                  Text(
                    context.t.mobileScreens.main.menu.userGuide,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: AppStyles.cabinetMenuTextColor,
                    ),
                  ),
                ],
              ),
            ),
          );

  Future<void> _downloadFile(String url) async {
    final anchorElement =  AnchorElement(href: url);
    anchorElement
      ..setAttribute('download', 'HelpPay.pdf')
      ..download
      ..click();
    // anchorElement.click();
  }
}