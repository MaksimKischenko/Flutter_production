import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';


class FlashButton extends StatelessWidget {
  final MobileScannerController cameraController;
  
  const FlashButton({
    Key? key,
    required this.cameraController,
  }): super(key: key);

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
          // tooltip: context.t.screens.qrScan.flashButton.turnOn,
          tooltip: 'Выключить вспышку',
          onPressed: cameraController.toggleTorch,
        );
      } else {
        return IconButton(
          icon: const Icon(
            Icons.flash_on,
            color: Colors.white,
          ),
          // tooltip: context.t.screens.qrScan.flashButton.turnOff,
          tooltip: 'Включить вспышку',
          onPressed: cameraController.toggleTorch,
        );
      }
    }
  );
}