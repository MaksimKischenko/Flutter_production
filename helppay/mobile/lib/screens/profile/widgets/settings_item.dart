import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay_core/helppay_core.dart';

class SettingsItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: Navigation.toSettings,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset(
            'assets/icon/profile_settings.svg',
            width: 23,
          ),
          const SizedBox(width: 12),
          Text(
            context.t.mobileScreens.profile.settingsItem.title,
            style: const TextStyle(
              color: Color(0xff383A51),
              fontSize: 18,
            ),
          )
        ],
      ),
    ),
  );
}