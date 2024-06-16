import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_cabinet_nkfo/blocs/blocs.dart';
import 'package:web_cabinet_nkfo/navigation.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class SplashScreen extends StatefulWidget {
  static const pageName = 'Загрузка';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => context.read<AuthBloc>().add(AuthCheck(getAbsolutePath(context))));
  }

  @override
  Widget build(BuildContext context) => BlocListener<AuthBloc, AuthState>(
    listener: (context, state) {
      if (state is AuthUnauthorized) {
        if (state.needToNavigate) Navigation.toAuth(next: state.next);
      } else if (state is AuthAuthorized) {
        if (state.needToNavigate) Navigation.toOrganizations();
      }
    },
    child: const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: double.maxFinite),
          LoadingIndicator(
            indicatorsSize: 80,
          )
        ],
      ),
    ),
  );
}