import 'package:flutter/material.dart';

class CheckQrButton extends StatelessWidget {
  final VoidCallback onTap;

  const CheckQrButton({
    required this.onTap
  });

  @override
  Widget build(BuildContext context) => IconButton(
    icon: const Icon(Icons.qr_code),
    tooltip: 'Проверить QR',
    onPressed: onTap,
  );
}