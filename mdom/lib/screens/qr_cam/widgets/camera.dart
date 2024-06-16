import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'widgets.dart';

class QrCamWidget extends StatefulWidget {
  final MobileScannerController cameraController;
  final bool scanOnlyOne;
  final Function(String? scanData) onScan;

  const QrCamWidget(
      {required this.cameraController,
      required this.onScan,
      this.scanOnlyOne = false});

  @override
  _QrCamWidgetState createState() => _QrCamWidgetState();
}

class _QrCamWidgetState extends State<QrCamWidget> {
  String? currentQr;

  final double qrMaxWidth = 300;
  double get qrWidth {
    final normalWidth = MediaQuery.of(context).size.width * 0.55;
    return normalWidth > qrMaxWidth ? qrMaxWidth : normalWidth;
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<QrCamBloc, QrCamState>(
        builder: (context, state) {
          Widget body = Container();
          if (state is QrCamLoading) {
            body = const SafeArea(child: Center(child: LoadingIndicator()));
          } else if (state is QrCamPermissionDenied) {
            body = SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Вы не предоставили разрешение доступа к камере',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    MaterialButton(
                      onPressed: () =>
                          context.read<QrCamBloc>().add(QrCamPermissionCheck()),
                      child: const Text('Предоставить'),
                    )
                  ],
                ),
              ),
            );
          } else if (state is QrCamPermissionPermamentlyDenied) {
            body = SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Доступ к камере пермаментно заблокирован вами или политикой безопасности телефона',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          } else if (state is QrCamPermissionGranted) {
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
                          cutOutSize: qrWidth
                          // cutOutSize: 200
                          ),
                    ),
                  ),
                ),
                // SafeArea(
                //   child: Container(
                //     padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                //     alignment: Alignment.topCenter,
                //     child: const Text(
                //       // context.t.screens.qrScan.qrCam.scanMessage,
                //       '',
                //       style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 22
                //       ),
                //     ),
                //   ),
                // ),
                const ScanStatus(),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: ClaimInfo(),
                )
              ],
            );
          }
          return body;
        },
      );

  void _onDetect(BarcodeCapture barcode) {
    if (barcode.raw != null) {
      widget.onScan(barcode.raw!);
    }
  }
}
