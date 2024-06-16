import 'package:fl_qr_module/styles.dart';
import 'package:fl_qr_module/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: double.infinity,   
    child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const MultiplatformIndicator(),
            const SizedBox(height: 16),
            Text(
              'Пожалуйста, подождите',
              style: TextStyle(
                color: AppStyles.mainColorDark.withOpacity(0.5),
                fontSize: 16,
                // fontWeight: FontWeight.w600
              ),
            )
          ],
        ),
  );
}
