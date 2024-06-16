import 'package:auto_route/auto_route.dart';
import 'package:bpc/config.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';


@RoutePage()
class AboutAppScreen extends StatelessWidget {
  static const pageRoute = '/about';

  const AboutAppScreen({
    Key? key,
  }): super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('О приложении')
    ),
    body: FullScreen(
      topSafe: false,
      bottomSafe: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            const AppLogo(
              size: 100,
            ),
            // const SizedBox(height: 24),
            // const Text(
            //   'Мой Дом',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     fontSize: 16,
            //     fontWeight: FontWeight.bold
            //     // color: Theme.of(context).textTheme.
            //   ),
            // ),
            const SizedBox(height: 8),
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const SizedBox();
                return Text(
                  'Версия ${snapshot.data!.version} build ${snapshot.data!.buildNumber}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppStyles.mainTextColor.withOpacity(0.8),
                  ),
                );
              }
            ),
            const SizedBox(height: 64),
            Text(
              AppConfig.copyright,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16
              ),
            ),
            InkWell(
              onTap: _openSite,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  AppConfig.organizationSiteTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Связаться с нами',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16
              ),
            ),
            InkWell(
              onTap: _openMail,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  AppConfig.contactEmail,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor
                  )
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    ),
  );

  void _openSite() => launchUrl(Uri.parse(AppConfig.organizationSiteUrl));

  void _openMail() => launchUrl(Uri.parse('mailto:${AppConfig.contactEmail}'));
}