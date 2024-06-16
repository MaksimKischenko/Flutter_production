import 'package:bpc_nkfo/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FlashButton extends StatefulWidget {
  @override
  _FlashButtonState createState() => _FlashButtonState();
}

class _FlashButtonState extends State<FlashButton> {
  bool _currentFlash = false;

  @override
  Widget build(BuildContext context) => IconButton(
    icon: Icon(
      !_currentFlash
          ? Icons.flash_on
          : Icons.flash_off,
      color: Colors.white,
    ),
    tooltip: 'Включить вспышку',
    onPressed: () {
      context.read<QrCamBloc>().add(QrCamToggleFlash());
      setState(() {
        _currentFlash = !_currentFlash;
      });
    },
  );
}