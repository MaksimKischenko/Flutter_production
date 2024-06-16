import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';

import 'main_widgets.dart';

class PopularServicesScreenMainBody extends StatelessWidget {
  final bool isDevice;

  const PopularServicesScreenMainBody({
    Key? key,
    required this.isDevice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            Widget mainBody = Container();
            if (state is AuthLoading) {
              mainBody = Expanded(
                child: Center(
                  child: LoadingIndicator(),
                ),
              );
            } else if (state is AuthAuthorized) {
              mainBody = PopularServicesScreenMainBodyContent(
                isDevice: isDevice,
              );
            }
            return mainBody;
          },
        ),
      ],
    );
  }
}
