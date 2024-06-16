import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'main_widgets.dart';

class InitHelppayServicesScreenMainBody extends StatefulWidget {
  final SizingInformation sizingInformation;

  const InitHelppayServicesScreenMainBody({
    Key? key,
    required this.sizingInformation,
  }) : super(key: key);

  @override
  State<InitHelppayServicesScreenMainBody> createState() =>
      _InitHelppayServicesScreenMainBodyState();
}

class _InitHelppayServicesScreenMainBodyState
    extends State<InitHelppayServicesScreenMainBody> {
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
              mainBody = InitHelppayServicesBodyContent(
                sizingInformation: widget.sizingInformation,
              );
            }
            return mainBody;
          },
        ),
      ],
    );
  }
}
