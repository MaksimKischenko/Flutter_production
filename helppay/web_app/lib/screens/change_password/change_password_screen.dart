import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/injection_component.dart';
import 'package:helppay_web_app/screens/change_password/main_widgets/change_password_screen_body.dart';

@RoutePage()
class ChangePasswordScreen extends StatefulWidget {
  static const PageInfo<dynamic> routePage = PageInfo('/change_password');

  static const pageRoute = '/change_password';

  const ChangePasswordScreen();

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => ChangePasswordBloc(
          dataManager: InjectionComponent.getDependency<DataManager>(),
        )..add(ChangePasswordInit()),
        child: const ChangePasswordScreenBody(),
      );
}
