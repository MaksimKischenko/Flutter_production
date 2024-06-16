import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/injection_component.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'widgets/widgets.dart';


@RoutePage()
class QrCamScreen extends StatefulWidget {
  static const pageRoute = '/qrCam';

  final DateTime initialDateFrom;

  const QrCamScreen({required this.initialDateFrom});

  @override
  _QrCamScreenState createState() => _QrCamScreenState();
}

class _QrCamScreenState extends State<QrCamScreen> {
  final _cameraController = MobileScannerController();

  late DateTime from;

  @override
  void initState() {
    from = widget.initialDateFrom;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocProvider<ClaimQrBloc>(
        create: (_) => ClaimQrBloc(
          dataManager: InjectionComponent.getDependency<DataManager>(),
        ),
        child: BlocBuilder<QrCamBloc, QrCamState>(builder: (context, state) {
          final isPermissionGranted = state is QrCamPermissionGranted;
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.light,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              title: DateFromSelector(
                value: from,
                onSelect: (value) => setState(() {
                  from = value;
                }),
              ),
              actions: [
                if (isPermissionGranted)
                  FlashButton(
                    cameraController: _cameraController,
                  ),
              ],
            ),
            extendBodyBehindAppBar: true,
            body: QrCamWidget(
              cameraController: _cameraController,
              onScan: _qrParse,
            ),
          );
        }),
      );

  void _qrParse(String? qrString) {
    if (kDebugMode) {
      print('found: $qrString');
    }
    if (qrString != null) {
      context
          .read<ClaimQrBloc>()
          .add(ClaimQrCheck(qrData: qrString, from: from));
    }
    // Navigator.of(context).pop(qrString);
  }
}
