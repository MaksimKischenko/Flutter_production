import 'package:flutter/material.dart';

import 'package:helppay_payform_app/utils/web_helper/web_helper.dart';

class ServiceScreenImage extends StatelessWidget {
  final String image;

  const ServiceScreenImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          redirectTo('https://www.raschet.by/', openType: OpenType.newTab),
      child: Image.asset(image),
    );
  }
}
