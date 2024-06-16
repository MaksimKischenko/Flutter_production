import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';

import 'widgets.dart';

class ServiceScreenMainBody extends StatelessWidget {
  final bool isDevice;
  final int code;

  const ServiceScreenMainBody(
      {Key? key, required this.isDevice, required this.code})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool firstLoad = true;

    return Column(
      children: [
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            Widget mainBody = Container();

            if (state is AuthLoading) {
              mainBody = Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    SizedBox(width: double.maxFinite),
                    LoadingIndicator()
                  ],
                ),
              );
            } else if (state is AuthAuthorized) {
              if (firstLoad) {
                context.read<ServicesBloc>().add(ServicesInit(code));
                firstLoad = false;
              }

              mainBody = ServiceScreenMainBodyContent(
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
