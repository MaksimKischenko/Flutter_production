import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';

import 'main_widgets.dart';

class CheckScreenBody extends StatelessWidget {
  final bool isDevice;
  final AttrRecordResponse suplierName;
  final AttrRecordResponse suplierValueName;
  const CheckScreenBody({
    Key? key,
    required this.isDevice,
    required this.suplierName,
    required this.suplierValueName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Column(
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
                  mainBody = CheckScreenBodyContent(
                    isDevice: isDevice,
                    suplierName: suplierName,
                    suplierValueName: suplierValueName,
                  );
                }
                return mainBody;
              },
            ),
          ],
        ),
      );
}
