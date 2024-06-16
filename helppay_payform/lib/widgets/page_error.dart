import 'package:flutter/cupertino.dart';
import 'package:helppay_payform_app/styles.dart';

import 'widgets.dart';

class PageError extends StatelessWidget {
  final String message;
  final Function() onRepeatTap;

  const PageError({
    required this.message,
    required this.onRepeatTap
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      // mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SvgAssets('icon/dialog_error.svg'),
        const SizedBox(height: 8),
        const Text(
          'Ошибка',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppStyles.mainTextColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.4
          ),
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppStyles.secondaryTextColor,
            fontSize: 16,
            // fontWeight: FontWeight.w600
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: CupertinoDialogAction(
                onPressed: onRepeatTap,
                child: const Text(
                  'Повторить',
                  style: TextStyle(
                    color: AppStyles.mainColor
                  ),
                ),
              ),
            ),
            // Expanded(
            //   child: CupertinoDialogAction(
            //     onPressed: () {
            //       Navigator.pop(context);
            //     },
            //     child: const Text(
            //       "ОК",
            //       style: TextStyle(
            //         color: Color(0xffFF3B30)
            //       ),
            //     ),
            //   ),
            // ),
          ],
        )
      ],
    ),
  );
}