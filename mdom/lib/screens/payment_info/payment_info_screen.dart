import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/screens/screens.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/widgets.dart';


@RoutePage()
class PaymentInfoScreen extends StatefulWidget {
  // static const pageRoute = '/payments/info';
  static const pageRoute = '${PaymentsScreen.pageRoute}/:info';

  final Payment payment;

  const PaymentInfoScreen({
    Key? key,
    required this.payment,
  }) : super(key: key);

  @override
  State<PaymentInfoScreen> createState() => _PaymentInfoScreenState();
}

class _PaymentInfoScreenState extends State<PaymentInfoScreen> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider<PaymentInfoBloc>(
        create: (context) =>
            PaymentInfoBloc(payment: widget.payment)..add(PaymentInfoInit()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Детализация платежа'),
          ),
          body: BlocBuilder<PaymentInfoBloc, PaymentInfoState>(
            builder: (context, state) {
              Widget body = Container();
              if (state is PaymentInfoLoading) {
                body = Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: double.maxFinite,
                    ),
                    LoadingIndicator()
                  ],
                );
              } else if (state is PaymentInfoInitial) {
                body = WebConstrainedBox(
                  child: Scrollbar(
                    controller: scrollController,
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: state.info.length,
                      itemBuilder: (context, i) {
                        final key = state.info.keys.elementAt(i);
                        return InfoItem(
                          title: key,
                          subtitle: state.info[key],
                        );
                      },
                    ),
                  ),
                );
              }
              return body;
            },
          ),
        ),
      );
}
