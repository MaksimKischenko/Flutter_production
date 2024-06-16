import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrPicture extends StatelessWidget {
  final String data;
  final double size;

  const QrPicture({
    required this.data,
    this.size = 150
  });
  
  @override
  Widget build(BuildContext context) => QrImageView(
    data: data,
    version: QrVersions.auto,
    size: size - 12
  );
}