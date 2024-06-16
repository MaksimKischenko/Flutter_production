import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isc_web_app/blocs/blocs.dart';
import 'package:isc_web_app/data/data.dart';
import 'package:isc_web_app/screens/claim_info/widgets/widgets.dart';
import 'package:isc_web_app/styles.dart';
import 'package:isc_web_app/widgets/widgets.dart';



@RoutePage()
class PaymentInfoScreen extends StatefulWidget {

  static const pageRoute = '/paymentInfo';

  final int? paymentId;
  final PaymentISC? payment;

  const PaymentInfoScreen({
    Key? key,
    @PathParam('id') this.paymentId,   
    this.payment,
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
      create: (context) => PaymentInfoBloc(payment: widget.payment)..add(PaymentInfoInit()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Детализация платежа', style: AppStyles.headerTextStyle),
        ),
        body: BlocBuilder<PaymentInfoBloc, PaymentInfoState>(
          builder: (context, state) {
            Widget body = Container();
            if (state is PaymentInfoLoading) {
              body = Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(width: double.maxFinite),
                  LoadingIndicator()
                ],
              );
            } else if (state is PaymentInfoInitial) {
              body = Padding(
                padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 160),
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.max, 
                    children: [
                    const SizedBox(height: 16),
                    InfoList(state.info),
                  ]),
                ),
              );              
            }
            return body;
          },
        ),
      ),
    );
}
