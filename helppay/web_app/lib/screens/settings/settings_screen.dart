import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/routing/routes.gr.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

/// This screen dosnt used in web version of app
class SettingsScreen extends StatefulWidget {
  static const PageInfo<dynamic> routePage = PageInfo('/settings');

  static const pageRoute = '/settings';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        extendBody: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => AutoRouter.of(context).pushAndPopUntil(
                          const ProfileRoute(),
                          predicate: (route) => false),
                      child: const Icon(Icons.arrow_back, size: 32)),
                  PageTitle(text: context.t.mobileScreens.settings.title),
                ],
              ),
            ),
            // SectionTitle(
            //   context.t.mobileScreens.settings.sections.access.title,
            // ),
            // Separator(),
            // const SizedBox(height: 16),
            // SectionTitle(
            //   context.t.mobileScreens.settings.sections.account.tilte,
            // ),
          ],
        ),
      );

  // ignore: avoid_void_async
}
