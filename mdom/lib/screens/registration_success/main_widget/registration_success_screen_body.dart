import 'package:bpc/blocs/registration/registration_bloc.dart';
import 'package:bpc/screens/registration_success/widgets/widgets.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/utils/utils.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegistrationSuccessScreenBody extends StatelessWidget {
  const RegistrationSuccessScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    const maintextStyle = TextStyle(
      color: AppStyles.mainTextColor,
      fontSize: 16,
      letterSpacing: -0.1,
      fontWeight: FontWeight.w300,
      // height: 1.2
    );
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: FullScreen(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icon/dialog_success.svg',
                    width: 76,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
                    child: Text(
                      'Готово!',
                      style: maintextStyle.copyWith(
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: 170,
                      child: Text(
                        'Вы успешно прошли регистрацию',
                        textAlign: TextAlign.center,
                        style: maintextStyle.copyWith(
                          color: AppStyles.mainTextColor.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(64, 8, 64, 8),
            child: Text(
              'Необходимо настроить функцию быстрого входа с помощью Passcode',
              textAlign: TextAlign.center,
              style: maintextStyle.copyWith(
                color: AppStyles.mainTextColor.withOpacity(0.5),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: BottomButton(
              text: 'Настроить',
              onPressed: () => _onSetPinTap(context),
            ),
          ),
        ],
      ),
    );
  }

  void _onSetPinTap(BuildContext context) {
    Multiplatform.showVerifyPinScreen(
        context: context,
        title: 'Придумайте PIN',
        onSuccess: (String pin) {
          context.read<RegistrationBloc>().add(RegistrationSetPin(
                pin: pin,
              ));
        });
  }
}
