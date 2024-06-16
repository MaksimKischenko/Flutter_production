import 'package:flutter/material.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay/screens/mdom_account_service_statistics.dart/widgets/widgets.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

class MdomAccountServiceStatistics extends StatelessWidget {
  final List<PaymentBilling> payments;
  final List<MdomService> services;
  final MdomAccountInfoLoaded state;
  const MdomAccountServiceStatistics({
    super.key,
    required this.payments,
    required this.services,
    required this.state,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: DialogTitle(
          text: context.t.mobileScreens.mdomAccountInfo.serviceSection.tilte,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SectionTitle(
              //     context.t.mobileScreens.mdomAccountInfo.serviceSection.tilte),
              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 8),
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    state.periodInfo?.servicesWrapper?.services?.length ?? 0,
                itemBuilder: (context, index) {
                  final service =
                      state.periodInfo!.servicesWrapper!.services![index];
                  return ServiceItem(
                    service: service,
                    onTap: _onServiceTap,
                  );
                },
              ),
            ],
          ),
        ),
      );

  void _onServiceTap(MdomService service, BuildContext context) {
    final sortedServices =
        services.where((element) => element.id == service.id).toList();

    Navigation.toMdomServiceInfo(
      context: context,
      service: service,
      services: sortedServices,
      payments: payments,
    );
  }
}
