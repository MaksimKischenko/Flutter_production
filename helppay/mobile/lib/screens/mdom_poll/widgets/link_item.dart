import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.t.mobileScreens.mdomPoll.linkItem,
                style: TextStyle(
                  color: const Color(0xff383a51).withOpacity(0.6),
                  fontSize: 16
                ),
              ), 
              const SizedBox(height: 12),    
              Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.blue,
                  decoration: TextDecoration.underline
                ),
              ),
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