import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/injection_component.dart';
import 'package:bpc/screens/change_password/main_widgets/change_password_screen_body.dart';
import 'package:bpc/screens/change_password/main_widgets/change_password_screen_web_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


@RoutePage()
class ChangePasswordScreen extends StatelessWidget {
  static const pageRoute = '/change_password';
  final ScrollController? controller;

  const ChangePasswordScreen({this.controller});

  @override
  Widget build(BuildContext context) => BlocProvider<ChangePasswordBloc>(
        create: (context) => ChangePasswordBloc(
          dataManager: InjectionComponent.getDependency<DataManager>(),
        ),
        child: kIsWeb
            ? const ChangePasswordScreenWebBody()
            : ChangePasswordScreenBody(
                controller: controller,
              ),
      );
}
