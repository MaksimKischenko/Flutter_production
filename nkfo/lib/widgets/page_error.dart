import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_cabinet_nkfo/styles.dart';

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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SvgAssets('icon/dialog_error.svg'),
        const SizedBox(height: 8),
        Text(
          'Ошибка',
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(
            color: AppStyles.mainTextColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.4
          ),
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(
            color: AppStyles.mainTextColor.withOpacity(0.7),
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: CupertinoDialogAction(
                onPressed: onRepeatTap,
                child: Text(
                  'Повторить',
                  style: GoogleFonts.openSans(
                    color: AppStyles.mainColor
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}