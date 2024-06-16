import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/routing/routes.gr.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

@RoutePage()
class RegistrationSuccessScreen extends StatefulWidget {
  static const PageInfo<dynamic> routePage = PageInfo('/registration_success');

  static const pageRoute = '/registration/success';

  const RegistrationSuccessScreen({Key? key}) : super(key: key);

  @override
  _RegistrationSuccessScreenState createState() =>
      _RegistrationSuccessScreenState();
}

class _RegistrationSuccessScreenState extends State<RegistrationSuccessScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360, maxHeight: 600),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icon/dialog_success.svg',
                    width: 76,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    context.t.mobileScreens.registrationSuccess.title,
                    style: const TextStyle(
                        color: AppStyles.mainColorDark,
                        fontSize: 21,
                        letterSpacing: -0.1,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 170,
                    child: Text(
                        context.t.mobileScreens.registrationSuccess.message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppStyles.mainColorDark.withOpacity(0.5),
                          fontSize: 16,
                          letterSpacing: -0.1,
                          fontWeight: FontWeight.w300,
                        )),
                  ),
                  const SizedBox(height: 16),
                  NoSplashButton(
                    withAddIcon: false,
                    onTap: () => AutoRouter.of(context).pushAndPopUntil(
                        AuthRoute(),
                        predicate: (route) => false),
                    text: 'Вернуться к авторизации',
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
