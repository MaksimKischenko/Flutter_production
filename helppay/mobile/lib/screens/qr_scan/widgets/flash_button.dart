import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:mobile_scanner/mobile_scanner.dart';


class FlashButton extends StatelessWidget {
  final MobileScannerController cameraController;

  const FlashButton({
    required this.cameraController
  });

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: cameraController.torchState,
    builder: (context, state, child) {
      if (state == TorchState.on) {
        return IconButton(
          icon: const Icon(
            Icons.flash_off,
            color: Colors.white,
          ),
          tooltip: context.t.mobileScreens.qrScan.flashButton.turnOn,
          onPressed: cameraController.toggleTorch,
        );
      } else {
        return IconButton(
          icon: const Icon(
            Icons.flash_on,
            color: Colors.white,
          ),
          tooltip: context.t.mobileScreens.qrScan.flashButton.turnOff,
          onPressed: cameraController.toggleTorch,
        );
      }
    }
  );
}