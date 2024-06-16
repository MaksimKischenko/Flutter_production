import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrPicture extends StatelessWidget {
  final String data;
  final double size;
  final bool isRealQr;

  const QrPicture({
    required this.data,
    this.size = 150,
    this.isRealQr = false,
  });

  @override
  Widget build(BuildContext context) => QrImageView(
        data: data,
        version: QrVersions.auto,
        size: size - 12,
        eyeStyle: isRealQr ? const QrEyeStyle(eyeShape: QrEyeShape.square, color: Colors.black):
        QrEyeStyle(eyeShape: QrEyeShape.square, color: Colors.grey.shade400)
        // foregroundColor: isRealQr ? Colors.black : Colors.grey.shade400,
      );
}
