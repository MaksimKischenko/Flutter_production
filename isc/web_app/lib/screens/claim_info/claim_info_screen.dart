import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isc_web_app/blocs/blocs.dart';
import 'package:isc_web_app/data/data.dart';
import 'package:isc_web_app/models/models.dart';
import 'package:isc_web_app/routing/routes.gr.dart';
import 'package:isc_web_app/screens/claim_info/widgets/widgets.dart';
import 'package:isc_web_app/screens/claims/widgets/qr_picture.dart';
import 'package:isc_web_app/styles.dart';
import 'package:isc_web_app/widgets/widgets.dart';


@RoutePage()
class ClaimInfoScreen extends StatelessWidget {
  static const pageRoute = '/claimInfo';

  final int? claimId;
  final Claim? claim;

  const ClaimInfoScreen({
    @PathParam('id') this.claimId,
    this.claim,
    Key? key,
  }) : super(key: key);

  bool get isPaymentUnable => (claim?.status == ClaimStatus.fullyPaid) || (claim?.status == ClaimStatus.overdue); 

  @override
  Widget build(BuildContext context) => BlocProvider<ClaimInfoBloc>(
    create: (context) => ClaimInfoBloc(
      id: claimId,
      claim: claim
    )..add(ClaimInfoInit()),
    child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: isPaymentUnable? null : () {
              AutoRouter.of(context).push(
                RegisterPaymentClaimRoute(claimId: claim?.id)
              );
            }, 
            icon: const Icon(Icons.payment)
          ),
        ], 
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:CrossAxisAlignment.center,
          children: const [
            Text('Детализация требования', style: AppStyles.headerTextStyle),
          ],
        ),
      ),
      body: BlocBuilder<ClaimInfoBloc, ClaimInfoState>(
          builder: (context, state) {
        Widget body = Container();
        if (state is ClaimInfoLoading) {
          body = Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(width: double.maxFinite),
              LoadingIndicator()
            ],
          );
        } else if (state is ClaimInfoInitial) {
          body = Padding(
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 160),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.max, 
                children: [
                const SizedBox(height: 16),  
                QrPicture(data: claim?.qrCode ?? 'Неизвестно', size: 150),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: InfoList(state.info)
                  )
                ),
              ]),
            ),
          );
        }
        return body;
      }),
    ),
  );
}
