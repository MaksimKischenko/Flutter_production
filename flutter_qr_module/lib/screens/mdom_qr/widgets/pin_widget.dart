import 'package:fl_qr_module/blocs/blocs.dart';
import 'package:fl_qr_module/screens/mdom_qr/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_autofill/sms_autofill.dart';

// void _log(dynamic message) => Logger.helpPayLog(message, name: 'pin_widet');

class PinFieldWidget extends StatefulWidget {
  final bool showPinWidget;
  // final String appSignatureID;
  final QrRequestState state;
  final double qrFrameSize;
  const PinFieldWidget({
    super.key,
    this.showPinWidget = true,
    required this.state,
    required this.qrFrameSize,
    // required this.appSignatureID,
  });

  @override
  State<PinFieldWidget> createState() => _PinFieldWidgetState();
}

class _PinFieldWidgetState extends State<PinFieldWidget> {
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

    _pinFieldController.dispose();

    super.dispose();
  }

  Future<void> listenOtp() async {
    // await SmsAutoFill().unregisterListener();
    // listenForCode();
     SmsAutoFill().listenForCode;
  }

  void codeUpdated() {
    if (_pinFieldController.text != _currentCode) {
      _pinFieldController.value = TextEditingValue(text: _currentCode ?? '');
    }
  }

  //final newSize = MediaQuery.of(context).size.width - widget.qrFrameSize;
  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: 16),
          const Text('Подтвердите операцию'),
          const SizedBox(height: 8),
          SizedBox(
            width: MediaQuery.of(context).size.width - widget.qrFrameSize,
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
                if (code.isNotEmpty &&
                    (widget.state is GetQrRequestLoaded ||
                        widget.state
                            is QrRequestConfirmQrChangeUiAfterStatusSuccess)) {
                  BlocProvider.of<QrRequestBloc>(context).add(
                    ConfirmQrPaymentRequestRun(
                        requestId: widget.state.requestId,
                        code: int.parse(code)),
                  );
                }
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
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width - 48,
            child: ActionButton(
              fontSize: 14,
              title: 'Подтвердить',
              onTap: () async {
                // await Multiplatform.showMessage(
                //   context: context,
                //   title: 'QR оплата',
                //   message: 'Оплачено успешно',
                //   type: DialogType.success,
                //   showReceipt: true,
                //   onPressed: () =>
                //       BlocProvider.of<QrRequestStatusBloc>(context).add(
                //     GetCheckDuplicate(requestId: widget.state.requestId),
                //   ),
                // );
                if ((_currentCode?.length == 4) &&
                    (_currentCode?.isNotEmpty ?? false) &&
                    (widget.state is GetQrRequestLoaded ||
                        widget.state
                            is QrRequestConfirmQrChangeUiAfterStatusSuccess)) {
                  BlocProvider.of<QrRequestBloc>(context).add(
                    ConfirmQrPaymentRequestRun(
                        requestId: widget.state.requestId,
                        code: int.parse(_currentCode!)),
                  );
                }
              },
            ),
          ),
        ],
      );
}
