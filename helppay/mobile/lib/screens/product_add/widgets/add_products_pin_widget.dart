import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/screens/mdom_qr/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:sms_autofill/sms_autofill.dart';

// void _log(dynamic message) => Logger.helpPayLog(message, name: 'pin_widet');

class AddProductPinFieldWidget extends StatefulWidget {
  final List<MdomResponseParam> paymentMethodData;
  final int requestId;
  final String typePan;

  const AddProductPinFieldWidget({
    required this.requestId,
    required this.paymentMethodData,
    super.key,
    required this.typePan,
  });

  @override
  State<AddProductPinFieldWidget> createState() =>
      _AddProductPinFieldWidgetState();
}

class _AddProductPinFieldWidgetState extends State<AddProductPinFieldWidget> {
  late TextEditingController _pinFieldController;

  String? _currentCode = '';
  @override
  void initState() {
    // getsignature();
    _pinFieldController = TextEditingController();
    codeUpdated();
    _pinFieldController.addListener(() {
      if (_pinFieldController.text != _currentCode) {
        _currentCode = _pinFieldController.text;
      }
    });
    listenOtp();
    super.initState();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    print('unregisterListener');
    _pinFieldController.dispose();

    super.dispose();
  }

  void listenOtp() async {
    // await SmsAutoFill().unregisterListener();
    // listenForCode();
    await SmsAutoFill().listenForCode;
    print('OTP listen Called');
  }

  void codeUpdated() {
    if (_pinFieldController.text != _currentCode) {
      _pinFieldController.value = TextEditingValue(text: _currentCode ?? '');
    }
  }

  // _log('App signature - ${widget.appSignatureID}');
  //final newSize = MediaQuery.of(context).size.width / 2.5;
  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: 16),
          const Text('Подтвердите операцию'),
          const SizedBox(height: 8),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.5,
            child: PinFieldAutoFill(
              controller: _pinFieldController,
              codeLength: 4,
              decoration: UnderlineDecoration(
                textStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
              ),
              textInputAction: TextInputAction.done,
              onCodeSubmitted: (code) {
                // if (code.isNotEmpty &&
                //     (widget.state is GetQrRequestLoaded ||
                //         widget.state
                //             is QrRequestConfirmQrChangeUiAfterStatusSuccess)) {
                //   BlocProvider.of<QrRequestBloc>(context).add(
                //     ConfirmQrPaymentRequestRun(
                //         requestId: widget.state.requestId, code: int.parse(code)),
                //   );
                // }
              },
              onCodeChanged: (code) {
                print('onCodeChanged $code');
                setState(() {
                  _currentCode = code.toString();
                });
              },
              currentCode: _currentCode,
            ),
          ),
          const SizedBox(height: 40),
          // SizedBox(
          //   width: MediaQuery.of(context).size.width - 72,
          //   child:
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 48) / 2,
                  child: ActionButton(
                    fontSize: 14,
                    title: 'Отменить',
                    onTap: () async {
                      // await Navigator.pushAndRemoveUntil(
                      //   context,
                      //   MaterialPageRoute<Widget>(
                      //       builder: (context) => const ProductsScreen()),
                      //   (route) => false,
                      // );
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 48) / 2,
                  child: ActionButton(
                    fontSize: 14,
                    title: 'Подтвердить',
                    onTap: () async {
                      BlocProvider.of<PaymentMethodBloc>(context).add(
                        ConfirmPaymentMethod(
                          paymentMethodData: widget.paymentMethodData,
                          requestIdentifier: RequestIdentifier(
                            evalue: widget.requestId,
                            otpCode: _currentCode,
                            confirmCode: 1,
                          ),
                          typePan: widget.typePan,
                        ),
                      );
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          // ),
        ],
      );
}
