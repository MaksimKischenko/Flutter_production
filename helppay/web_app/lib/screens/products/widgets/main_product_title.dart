import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

class MainProductTitle extends StatelessWidget {
  final MainProductType mainProductType;

  const MainProductTitle({
    required this.mainProductType
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Text(
      mainProductType == MainProductType.account
          ? context.t.mobileScreens.products.mainProductTitle.account
          : context.t.mobileScreens.products.mainProductTitle.card,
      style: TextStyle(
        color: AppStyles.mainColorDark.withOpacity(0.6),
        fontSize: 16
      ),
    ),
  );
}