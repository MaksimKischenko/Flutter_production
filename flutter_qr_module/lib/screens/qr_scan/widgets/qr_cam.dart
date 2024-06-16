import 'package:fl_qr_module/blocs/blocs.dart';
import 'package:fl_qr_module/generated/translations.g.dart';
import 'package:fl_qr_module/models/dialog_type.dart';
import 'package:fl_qr_module/screens/screens.dart';
import 'package:fl_qr_module/utils/utils.dart';
import 'package:fl_qr_module/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'widgets.dart';

void _log(dynamic message) => Logger.helpPayLog(message, name: 'qr_cam');

class QrCamWidget extends StatefulWidget {
  final MobileScannerController cameraController;
  final Function(String scanData) onScan;

  const QrCamWidget({
    required this.cameraController,
    required this.onScan,
  });

  @override
  _QrCamWidgetState createState() => _QrCamWidgetState();
}

class _QrCamWidgetState extends State<QrCamWidget> {
  @override
  void dispose() {
    widget.cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<QrCamBloc, QrCamState>(
        listener: (context, state) async {
          if (state is QrCamRegisterPaymentLoading) {
            await Multiplatform.showLoaderDialog(context);
          }
          if (state is QrCamRegisterPaymentSuccess) {
            if (state.needPop ?? false) Navigator.pop(context);

            Future<void>.delayed(
              const Duration(seconds: 1),
              () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute<Widget>(
                    builder: (context) => const MainScreen()),
                (_) => false,
              ),
            );
            await Multiplatform.showMessage(
              context: context,
              title: 'Перевод средств',
              message: 'Запрос на перевод сформирован',
              type: DialogType.success,
            );
          }
          if (state is QrCamErrorKomplat) {
            final isTokenError = state.errorCode == 403;
            if (state.needPop ?? false) Navigator.pop(context);
            if (!isTokenError) {
              if (state.errorCode == 403) {
                context.read<QrRequestBloc>().add(GetSecretKeyRequestRun());
              } else {
                await RequestUtil.catchKomplatError(
                  context: context,
                  errorCode: state.errorCode,
                  errorText: state.errorMessage,
                );
              }
            }
          } else if (state is QrCamError) {
            if (state.needPop ?? false) Navigator.pop(context);
            await Multiplatform.showMessage(
              context: context,
              title: 'Ошибка',
              message: state.error
                  .toString()
                  .substring(11, state.error.toString().length),
              type: DialogType.error,
            );
          }
        },
        builder: (context, state) {
          Widget body = const SizedBox();
          if (state is QrCamLoading) {
            body =
                const SafeArea(child: Center(child: MultiplatformIndicator()));
          }
          if (state is QrCamPermissionDenied) {
            body = SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.t.mobileScreens.qrScan.qrCam.permissions.denied,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    MaterialButton(
                        onPressed: () => context
                            .read<QrCamBloc>()
                            .add(QrCamPermissionCheck()),
                        child: Text(context.t.mobileScreens.qrScan.qrCam
                            .providePermissionButton))
                  ],
                ),
              ),
            );
          }
          if (state is QrCamPermissionPermamentlyDenied) {
            body = SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.t.mobileScreens.qrScan.qrCam.permissions
                          .permamentlyDenied,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is QrCamPermissionGranted) {
            body = Stack(
              children: [
                MobileScanner(
                  // allowDuplicates: false,
                  controller: widget.cameraController,
                  onDetect: _onDetect,
                ),
                Padding(
                  padding: EdgeInsets.zero,
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: QrScannerOverlayShape(
                          borderLength: 25,
                          borderColor: const Color(0xff32C3A7),
                          borderWidth: 8,
                          cutOutSize: MediaQuery.of(context).size.width * 0.55
                          // cutOutSize: 200
                          ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                    alignment: Alignment.topCenter,
                    child: Text(
                      context.t.mobileScreens.qrScan.qrCam.scanMessage,
                      style: const TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                )
              ],
            );
          }
          return body;
        },
      );

  void _onDetect(BarcodeCapture barcode) {
    _log('barCode - ${barcode.raw}');
    if (barcode.raw != null) {
      widget.onScan(barcode.raw!.toString());
    }
  }
}
