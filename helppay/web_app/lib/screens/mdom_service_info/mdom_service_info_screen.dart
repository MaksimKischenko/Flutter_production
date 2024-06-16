import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/widgets/web_dialog_window.dart';

import 'widgets/widgets.dart';

class MdomServiceInfo extends StatefulWidget {
  final MdomService service;
  final List<MdomService> services;
  final List<PaymentBilling> payments;

  const MdomServiceInfo({
    Key? key,
    required this.service,
    required this.services,
    required this.payments,
  }) : super(key: key);

  @override
  _MdomServiceInfoState createState() => _MdomServiceInfoState();
}

class _MdomServiceInfoState extends State<MdomServiceInfo> {
  late Map<String, String> _info;
  bool showRequirements = false;

  @override
  void initState() {
    super.initState();
    _info = <String, String>{};
    showRequirements = widget.service.claimId != null;
  }

  @override
  void didChangeDependencies() {
    _info[context.t.mobileScreens.mdomAccountInfo.serviceSectionInfo.item
        .count] = '${widget.service.volume ?? 0.0}';
    _info[context.t.mobileScreens.mdomAccountInfo.serviceSectionInfo.item
        .units] = '${widget.service.unit ?? 0.0}';
    _info[context.t.mobileScreens.mdomAccountInfo.serviceSectionInfo.item
        .tarif] = '${widget.service.tariff ?? 0.0}';
    _info[context.t.mobileScreens.mdomAccountInfo.serviceSectionInfo.item
        .accrued] = widget.service.accrued.toStringAsFixed(2);
    _info[context.t.mobileScreens.mdomAccountInfo.serviceSectionInfo.item
            .recalculation] =
        (widget.service.recalculated ?? 0.0).toStringAsFixed(2);
    _info[context.t.mobileScreens.mdomAccountInfo.serviceSectionInfo.item
        .benefit] = (widget.service.benefit ?? 0.0).toStringAsFixed(2);
    _info[context.t.mobileScreens.mdomAccountInfo.serviceSectionInfo.item
        .total] = widget.service.total.toStringAsFixed(2);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => WebDialogWindow(
        title: widget.service.name,
        buttonTitle: context.t.mobileScreens.mdomServiceInfo.doneButton,
        buttonActive: true,
        useSpacer: false,
        onPressed: _onDoneTap,
        body: showRequirements
            ? RequirementsItem(
                services: widget.services,
                payments: widget.payments.toList(),
              )
            : ListView.separated(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                itemCount: _info.length,
                itemBuilder: (context, index) => InfoItem(
                  title: _info.keys.toList()[index],
                  subtitle: _info.values.toList()[index],
                ),
                separatorBuilder: (context, _) =>
                    Divider(color: AppStyles.mainColorDark.withOpacity(0.1)),
              ),
      );

  void _onDoneTap() {
    AutoRouter.of(context).pop();
  }
}
