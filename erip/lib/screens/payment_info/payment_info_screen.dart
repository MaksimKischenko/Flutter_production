import 'package:bpc_nkfo/blocs/blocs.dart';
import 'package:bpc_nkfo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/widgets.dart';

class PaymentInfoScreenNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Детализация платежа'),
    ),
    body: BlocBuilder<PaymentInfoBloc, PaymentInfoState>(
      builder: (context, state) {
        Widget body = Container();
        if (state is PaymentInfoLoading) {
          body = const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.maxFinite,
              ),
              LoadingIndicator()
            ],
          );
        }
        if (state is PaymentInfoInitial) {
          body = InfoList(state.info);
        }
        return body;
      },
    ),
  );
}