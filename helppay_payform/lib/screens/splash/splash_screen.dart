import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/injection_component.dart';
import 'package:helppay_payform_app/navigation.dart';
import 'package:helppay_payform_app/utils/url_resolver/url_resolver.dart';
import 'package:helppay_payform_app/utils/utils.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';

class SplashScreen extends StatefulWidget {
  static const pageName = 'Загрузка';
  static const pageRoute = '/';

  final String? returnUri;
  final String? token;
  final double? maxAmount;
  final DataManager? dataManager;

  SplashScreen({this.returnUri, this.token, this.maxAmount})
      : dataManager = InjectionComponent.getDependency<DataManager>();

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthorized) {
              if (widget.token != null)
                context
                    .read<PaymentsBloc>()
                    .add(PaymentsInit(state.maxAmount, state.payments));
              if (state.needToNavigate && widget.token != null)
                Navigation.toInitHelppayServices();
              // Navigation.toPopularServices();
            }
          },
          builder: (context, state) {
            Widget body = Container();
            if (state is AuthLoading) {
              body = Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(width: double.maxFinite),
                  LoadingIndicator()
                ],
              );
            } else if (state is AuthError) {
              body = PageError(
                message: state.error.toString(),
                onRepeatTap: _check,
              );
            }
            return body;
          },
        ),
      );

  void _check() {
    if (widget.token != null) {
      context.read<AuthBloc>().add(AuthRun(
          token: widget.token,
          path: getAbsolutePath(context),
          maxAmount: widget.maxAmount));
    }

    if (widget.returnUri != null) {
      context
          .read<ReturnBackBloc>()
          .add(ReturnBackInit(returnUri: widget.returnUri));
    }
  }
}
