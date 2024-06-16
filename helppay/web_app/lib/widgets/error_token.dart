import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

class ErrorToken extends StatelessWidget {
  final BuildContext context;
  final String message;
  final Function() onRepeatTap;

  const ErrorToken(
    this.context,
    {required this.message,
    required this.onRepeatTap
    }
  );

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
        Text(
          context.t.mobileScreens.payment.modal.error.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppStyles.mainColorDark,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.4
          ),
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppStyles.mainColorDark.withOpacity(0.5),
            fontSize: 16,
            // fontWeight: FontWeight.w600
          ),
        ),
      ],
    ),
  );
}