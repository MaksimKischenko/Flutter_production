import 'package:auto_route/auto_route.dart';
import 'package:bpc/data/routing/routes.gr.dart';
import 'package:bpc/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Error extends StatelessWidget {
  final BuildContext context;
  final int? errorCode;
  final String message;
  final Function() onRepeatTap;

  const Error(
    this.context, {
    required this.message,
    required this.onRepeatTap,
    this.errorCode,
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
            SvgPicture.asset('assets/icon/dialog_error.svg'),
            const SizedBox(height: 8),
            const Text(
              'Ошибка',
              // TODO
              // context.t.screens.payment.modal.error.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.4,
              ),
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppStyles.mainTextColor.withOpacity(0.5),
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
                      // TODO
                      // context.t.screens.payment.modal.error.repeatButton,
                      style: TextStyle(color: AppStyles.mainColor),
                    ),
                  ),
                ),
                Expanded(
                  child: CupertinoDialogAction(
                    onPressed: () {
                      if (errorCode == 119) {
                        AutoRouter.of(context).push(const AuthRoute());
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Ок',
                      // TODO
                      // context.t.screens.payment.modal.error.doneButton,
                      style: TextStyle(color: Color(0xffFF3B30)),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
}
