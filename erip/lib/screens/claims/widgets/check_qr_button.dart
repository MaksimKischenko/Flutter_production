import 'package:flutter/material.dart';

class CheckQrButton extends StatelessWidget {
  final Function()? onPressed;

  const CheckQrButton({
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) => IconButton(
    icon: const Icon(Icons.qr_code),
    tooltip: 'Проверить QR',
    onPressed: () => onPressed?.call()
  );
}