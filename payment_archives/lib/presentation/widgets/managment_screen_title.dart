import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:payment_tracking_module/presentation/styles.dart';

class ManagmentScreenTitle extends StatelessWidget {
  final String title;
  const ManagmentScreenTitle({
    required this.title,
  });
  

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => AutoRouter.of(context).back(),
              child: const Icon(Icons.arrow_left, size: 32, color: AppStyles.mainColor),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: AppStyles.headerTextStyle
            ),
          ],
        ),
      ],
    ),
  );
}