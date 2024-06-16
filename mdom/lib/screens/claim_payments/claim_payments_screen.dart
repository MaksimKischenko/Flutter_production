import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/injection_component.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/screens/claim_payments/main_widgets/claim_payments_screen_body.dart';
import 'package:bpc/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


@RoutePage()
class ClaimPaymentsScreen extends StatelessWidget {
  // static const pageRoute = '/claims/payments';
  static const pageRoute = '${ClaimsScreen.pageRoute}/:payments';

  final ClaimPaymentsData data;

  const ClaimPaymentsScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<PaymentsBloc>(
        create: (context) => PaymentsBloc(
          dataManager: InjectionComponent.getDependency<DataManager>(),
        ),
        child: ClaimPaymentsScreenBody(data: data),
      );
}
