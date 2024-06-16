import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/blocs/blocs.dart';
import 'package:helppay/screens/mdom_qr/widgets/widgets.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class P2PTransferDialogWidget extends StatefulWidget {
  const P2PTransferDialogWidget({super.key});

  @override
  State<P2PTransferDialogWidget> createState() =>
      _P2PTransferDialogWidgetState();
}

class _P2PTransferDialogWidgetState extends State<P2PTransferDialogWidget> {
  late TextEditingController? controller;
  late GlobalKey<FormState> _formKey; //for storing form state.

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback();
    controller = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 56,
            height: MediaQuery.of(context).size.height / 4,
            child: Material(
              color: Colors.white,
              elevation: 24,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              type: MaterialType.card,
              clipBehavior: Clip.none,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Text(
                      context.t.mobileScreens.qrPayment.p2PpaymentSum,
                      style: const TextStyle(
                          color: AppStyles.mainColorDark, fontSize: 18),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 3),
                      child: TransferSumTextField(
                        controller: controller,
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 56,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 3,
                            ),
                            child: ActionButton(
                              title: context
                                  .t.mobileScreens.qrPayment.cancelButtonTitle,
                              onTap: () => Navigator.of(context).pop(),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 3),
                            child: ActionButton(
                              title:
                                  context.t.mobileScreens.qrPayment.applyButton,
                              onTap: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  BlocProvider.of<QrRequestBloc>(context).add(
                                    GetQrRequestRun(
                                      paymentSum: double.tryParse(
                                              controller!.value.text) ??
                                          0,
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
