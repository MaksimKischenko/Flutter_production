import 'package:fl_qr_module/blocs/blocs.dart';
import 'package:fl_qr_module/generated/translations.g.dart';
import 'package:fl_qr_module/styles.dart';
import 'package:fl_qr_module/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'widgets/widgets.dart';

class QrScanScreen extends StatefulWidget {
  const QrScanScreen({
    Key? key,
  }) : super(key: key);

  @override
  _QrScanScreenState createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {
  final _cameraController = MobileScannerController();
  bool showAgreements = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<QrCamBloc, QrCamState>(
        builder: (context, state) {
          //Widget body = Container();
          final isPermissionGranted = state is QrCamPermissionGranted;

          return Scaffold(
            // backgroundColor: Colors.black,
            backgroundColor:
                isPermissionGranted ? Colors.black : AppStyles.scaffoldColor,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: SvgPicture.asset('assets/icon/close.svg',
                    colorFilter: isPermissionGranted
                        ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                        : const ColorFilter.mode(
                            AppStyles.mainColorDark, BlendMode.srcIn)
                    // color: isPermissionGranted
                    //     ? Colors.white
                    //     : AppStyles.mainColorDark,
                    ),
              ),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              actions: [
                if (isPermissionGranted)
                  FlashButton(
                    cameraController: _cameraController,
                  ),
              ],
            ),
            body: QrCamWidget(
              cameraController: _cameraController,
              onScan: _qrParse,
            ),
          );
        },
      );


  Future<void> _qrParse(String qrString) async {
    await _cameraController.stop();
    try {
      final resultUrl = qrString
          .split(',')
          .firstWhere((element) => element.contains('https'));
      final data = QrErip.parse(resultUrl);

      Navigator.pop<QrEripData>(context, data);
    } catch (e) {
      await Multiplatform.showMessage(
        context: context,
        title: context.t.mobileScreens.qrScan.modal.error.title,
        message: context.t.mobileScreens.qrScan.modal.error.message(error: e),
      );
    }
    await _cameraController.start();
  }
}
