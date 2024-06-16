import 'package:bpc_nkfo/blocs/blocs.dart';
import 'package:bpc_nkfo/styles.dart';
import 'package:bpc_nkfo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'widgets.dart';

class QrCamWidget extends StatefulWidget {
  final bool scanOnlyOne;
  final Function(String? scanData) onScan;

  const QrCamWidget({
    required this.onScan,
    this.scanOnlyOne = false
  });

  @override
  _QrCamWidgetState createState() => _QrCamWidgetState();
}

class _QrCamWidgetState extends State<QrCamWidget> with WidgetsBindingObserver {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController _controller;
  bool _isCameraActive = false;
  bool _currentFlash = false;

  String? currentQr;

  final double qrMaxWidth = 300;
  double get qrWidth {
    final normalWidth = MediaQuery.of(context).size.width * 0.55;
    return normalWidth > qrMaxWidth
        ? qrMaxWidth
        : normalWidth;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // if (Platform.isIOS) _controller?.pauseCamera();
    _controller
      ..pauseCamera()
      ..dispose();
    super.dispose();

  }

    @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // _controller?.pauseCamera();
    }
    if (state == AppLifecycleState.resumed) {
      // _controller?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<QrCamBloc, QrCamState>(
    listener: (context, state) {
      if (state is QrCamPemissionGranted) {
        if (_currentFlash != state.currentFlash) {
          _controller.toggleFlash();
          _currentFlash = state.currentFlash;
        }
      }
    },
    builder: (context, state) {
      Widget body = Container();
      if (state is QrCamLoading) {
        body = const SafeArea(
          child: Center(
            child: LoadingIndicator()
          )
        );
      }
      if (state is QrCamPemissionDenied) {
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
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                ),
                MaterialButton(
                  onPressed: () => BlocProvider.of<QrCamBloc>(context).add(QrCamPermissionCheck()),
                  child: const Text('Предоставить'),
                )
              ],
            ),
          ),
        );
      }
      if (state is QrCamPemissionPermamentlyDenied) {
        body = const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Доступ к камере пермаментно заблокирован вами или политикой безопасности телефона',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }
      if (state is QrCamPemissionGranted) {
        body = Stack(
          // alignment: Alignment.center,
          children: [
            QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderLength: 25,
                borderColor: AppStyles.mainColor,
                borderWidth: 8,
                cutOutSize: qrWidth
                // cutOutSize: 200
              ),
            ),
            ScanStatus(),
            Align(
              alignment: Alignment.bottomCenter,
              child: ClaimInfo(),
            )
          ],
        );
      }
      return body;
    },
  );

  void _onQRViewCreated(QRViewController controller) {
    _controller = controller;
    _isCameraActive = true;
    if (widget.scanOnlyOne) {
      controller.scannedDataStream.first.then((scanData) {
        widget.onScan(scanData.code);
      });
    } else {
      controller.scannedDataStream.where((element) => _isCameraActive && currentQr != element.code).listen((scanData) {
        currentQr = scanData.code;
        widget.onScan(scanData.code);
      });
    }
  }
}