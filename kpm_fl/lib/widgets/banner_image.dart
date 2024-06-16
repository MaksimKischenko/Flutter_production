import 'package:flutter/material.dart';

import 'widgets.dart';

class BannerImage extends StatelessWidget {
  final String url;

  const BannerImage(
    this.url, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Image.network(
    SettingsInfo.of(context).resourcesUrl + url,
    fit: BoxFit.fitWidth,
    errorBuilder: (context, e, stacktrace) => const SizedBox(),
  );
}