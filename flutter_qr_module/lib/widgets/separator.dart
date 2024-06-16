import 'package:fl_qr_module/styles.dart';
import 'package:flutter/material.dart';

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
