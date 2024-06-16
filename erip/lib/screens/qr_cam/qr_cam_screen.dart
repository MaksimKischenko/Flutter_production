import 'package:bpc_nkfo/blocs/blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/widgets.dart';

class QrCamScreen extends StatefulWidget {
  final DateTime initialDateFrom;

  const QrCamScreen({
    required this.initialDateFrom
  });
  
  @override
  _QrCamScreenState createState() => _QrCamScreenState();
}

class _QrCamScreenState extends State<QrCamScreen> {
  late DateTime from;

  @override
  void initState() {
    from = widget.initialDateFrom;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
        onSelect: (value) => setState((){ from = value; }),
      ),
      actions: [
        FlashButton(),
      ],
    ),
    extendBodyBehindAppBar: true,
    body: QrCamWidget(
      onScan: _qrParse,
      scanOnlyOne: false,
    ),
  );

  void _qrParse(String? qrString) {
    if (kDebugMode) {
      print('found: $qrString');
    }
    if (qrString != null) {
      context.read<ClaimQrBloc>().add(
        ClaimQrCheck(
          qrData: qrString,
          from: from
        )
      ); 
    }
    // Navigator.of(context).pop(qrString);    
  }
}