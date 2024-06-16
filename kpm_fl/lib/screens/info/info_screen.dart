import 'package:flutter/material.dart';
import 'package:kpm_fl/navigation.dart';
import 'package:kpm_fl/styles.dart';
import 'package:kpm_fl/widgets/widgets.dart';

import 'widgets/widgets.dart';

class InfoScreen extends StatefulWidget {
  static const pageRoute = '/info';

  const InfoScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  var _tapCount = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              BannerImage(ScreenInfo.of(context).info.logoUrl),
              const SizedBox(height: 16),
              PageTitle(ScreenInfo.of(context).info.title),
              const SizedBox(height: 16),
              Expanded(
                child: PdfDoc(SettingsInfo.of(context).resourcesUrl + ScreenInfo.of(context).info.pdfUrl),
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 300
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  width: double.maxFinite,
                  child: GradientButton(
                    onTap: _onHomeTap,
                    gradientColors: const [AppStyles.mainColor, AppStyles.mainColor],
                    child: Text(ScreenInfo.of(context).info.homeButtonLabel),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: _onSettingsTap,
              child: Container(
                width: 70,
                height: 70,
                color: Colors.transparent
                // color: Colors.red,
              ),
            ),
          )
        ],
      ),
    )
  );

  void _onSettingsTap() {
    if (_tapCount == 10) {
      Navigation.toSettings();
      _tapCount = 0;
    } else {
      _tapCount++;
    }
  }

  void _onHomeTap() {
    // Navigation.toPopularServices();
    Navigator.of(context).pop();
  }
}