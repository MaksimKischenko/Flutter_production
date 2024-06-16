import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:isc_web_app/generated/translations.g.dart';
import 'package:isc_web_app/widgets/widgets.dart';

import 'widgets/widgets.dart';


@RoutePage()
class ProfileScreen extends StatefulWidget {
  static const pageRoute = '/profile';

  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: const CabinetMenu(selectedIndex: 5),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 40),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 720,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
                      child: Row(
                        children: [
                          PageTitle(
                            text: context.t.mobileScreens.profile.title,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                      child: UserTitle(),
                    ),
                    Expanded(child: Card(child: UserParams())),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
