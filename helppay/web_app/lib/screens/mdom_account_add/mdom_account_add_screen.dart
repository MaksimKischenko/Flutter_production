import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/injection_component.dart';
import 'package:helppay_web_app/screens/mdom_account_add/main_widget/mdom_account_add_screen_body.dart';

class MdomAccountAddScreen extends StatelessWidget {
  const MdomAccountAddScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MdomCreateAccountBloc(
              dataManager: InjectionComponent.getDependency<DataManager>(),
            ),
          ),
          BlocProvider(
            create: (context) => InfoSupplierBloc(
              dataManager: InjectionComponent.getDependency<DataManager>(),
            ),
          ),
        ],
        child: const MdomAccountAddScreenBody(),
      );
}
