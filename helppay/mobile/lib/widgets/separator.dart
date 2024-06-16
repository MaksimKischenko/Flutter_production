import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';

class Separator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: 16, right: 16),
    child: Divider(
      color: AppStyles.mainColorDark.withOpacity(0.1),
      height: 1,
    ),
  );
}