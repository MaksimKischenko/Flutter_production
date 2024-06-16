import 'package:fl_qr_module/screens/mdom_qr/service_qr_screen_status_consumer.dart';
import 'package:flutter/material.dart';

// void _log(dynamic message) => Logger.helpPayLog(message, name: 'service');

class ServicesQrScreen extends StatefulWidget {
  static const pageRoute = '/qr';

  const ServicesQrScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ServicesQrScreenState createState() => _ServicesQrScreenState();
}

class _ServicesQrScreenState extends State<ServicesQrScreen> {

  @override
  Widget build(BuildContext context) => const Scaffold(
        // appBar: AppBar(
        //   title: const Text('QR-коды услуг'),
        // ),
        body: ServiceQrScreenStatusListener(),
      );
}
