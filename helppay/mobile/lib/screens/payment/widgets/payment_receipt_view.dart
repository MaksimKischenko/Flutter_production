import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets.dart';

class PaymentreceiptView extends StatefulWidget {
  final PayRecordResponse service;
  final List<String> checkBody;

  const PaymentreceiptView({
    required this.service,
    required this.checkBody,
  });

  @override
  _PaymentreceiptViewState createState() => _PaymentreceiptViewState();
}

class _PaymentreceiptViewState extends State<PaymentreceiptView> {
  final _titleKey = GlobalKey();

  double get titleSize => 40;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: const CloseButton(),
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        // padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                        child: PageTitle(
                            key: _titleKey, text: widget.service.name ?? ''),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              context.t.mobileScreens.payment.fieldsPage.qrPayVerifyData.checkTitle,
                              style: const TextStyle(
                                color: Color(0xff070707),
                                fontSize: 16,
                                letterSpacing: 0.01,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Divider(
                              color: Color(0xffEBEBEB),
                              height: 2,
                            ),
                            const SizedBox(height: 8),
                            ...widget.checkBody.map(
                              (e) => Text(
                                e.trim(),
                                style: const TextStyle(
                                  color: Color(0xff070707),
                                  fontSize: 16,
                                  letterSpacing: 0.01,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: NextButton(onPressed: _onTap, text: context.t.mobileScreens.payment.fieldsPage.finishButton),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      );

  void _onTap() {
    Navigator.of(context).pop();
  }
}
