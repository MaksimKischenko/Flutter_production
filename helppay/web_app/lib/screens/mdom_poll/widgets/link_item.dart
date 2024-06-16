import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkItem extends StatelessWidget {
  final String value;

  const LinkItem({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => FutureBuilder<bool>(
    future: canLaunchUrl(Uri.parse(value)),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return const SizedBox.shrink();
      if (!snapshot.data!) return const SizedBox.shrink();

      return GestureDetector(
        onTap: _onTap,
        behavior: HitTestBehavior.translucent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                context.t.mobileScreens.mdomPoll.linkItem,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppStyles.mainColor,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.chevron_right, 
                size: 18, 
                color: AppStyles.mainColor
              )
            ],
          ),
        ),
      );
    },
  );

  void _onTap() {
    launchUrl(Uri.parse(value));
  }
}