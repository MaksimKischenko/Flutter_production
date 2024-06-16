import 'package:flutter/cupertino.dart';
import 'package:kpm_fl/navigation.dart';
import 'package:kpm_fl/styles.dart';

import 'widgets.dart';

class PageError extends StatelessWidget {
  final String message;
  final Function() onRepeatTap;
  final bool showBottomBar;

  const PageError({
    required this.message,
    required this.onRepeatTap,
    this.showBottomBar = true
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Expanded(
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
            if (!showBottomBar)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: CupertinoDialogAction(
                onPressed: onRepeatTap,
                child: const Text(
                  'Повторить',
                  style: TextStyle(
                    color: AppStyles.mainColor
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      if (showBottomBar)
      // menu
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(width: 16),
              Expanded(
                child: GradientButton(
                  onTap: onRepeatTap,
                  gradientColors: AppStyles.buttonGradientColorsRed,
                  // TODO: add real text from ScreenInfo
                  child: const Text('Повторить'),
                  // child: Text(),
                )
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GradientButton(
                  onTap: _onHomeTap,
                  gradientColors: const [
                    AppStyles.mainColor,
                    AppStyles.mainColor,
                  ],
                  // TODO: add real text from ScreenInfo
                  child: const Text('Главное меню'),
                  // child: Text(),
                )
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ),
      const SizedBox(height: 16),
    ],
  );

  void _onHomeTap() {
    Navigation.toPopularServices();
    // Navigation.toSplash();
  }
}