import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isc_web_app/blocs/blocs.dart';
import 'package:isc_web_app/generated/translations.g.dart';
import 'package:isc_web_app/routing/routes.gr.dart';
import 'package:isc_web_app/styles.dart';
import 'package:isc_web_app/utils/utils.dart';
import 'package:isc_web_app/widgets/widgets.dart';


@RoutePage()
class SplashScreen extends StatefulWidget {
  static const pageRoute = '/';

  const SplashScreen({
    Key? key,
  }): super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthBloc, AuthState>(
    listener: (context, state) {
      if (state is AuthUnauthorized) {
          AutoRouter.of(context).pushAndPopUntil(AuthRoute(), predicate: (route) => false);         
      } 
      else if(state is AuthAuthorized) {
          if(getAbsolutePath(context).endsWith('/')) {
            context.read<AuthBloc>().add(AuthLogOut());
          } 
      }
    },
    builder: (context, state) {
      Widget body = Container();
      if (state is AuthInitial) {
        body = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Text(context.t.mobileScreens.splash.loadingMessage)
          ],
        );
      }
      if (state is AuthLoading) {
        body = Column(
          mainAxisSize: MainAxisSize.min,
          children:  [
            const MultiplatformIndicator(),
            const SizedBox(height: 16),
            Text(context.t.mobileScreens.splash.loadingMessage)
          ],
        );
      }
      if (state is AuthError) {
        body = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Text(
              RequestUtil.networkError,
              style: const TextStyle(
                color: AppStyles.mainColorDark,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.4
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      }
      if (state is AuthErrorKomplat) {
        body = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Text(
              state.errorMessage ?? context.t.mobileScreens.splash.errorMessage,
              style: const TextStyle(
                color: AppStyles.mainColorDark,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.4
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      }
      return Scaffold(
        body: FullScreen(
          bottomSafe: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Center(
                child: SvgPicture.asset('assets/images/logo.svg')
              ),
              const SizedBox(height: 64),
              body
            ],
          ),
        ),
      );
    },
  );
}