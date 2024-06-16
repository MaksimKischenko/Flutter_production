import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddServiceButton extends StatelessWidget {
  final Function() onTap;

  const AddServiceButton({
    required this.onTap
  });

  @override
  Widget build(BuildContext context) => Tooltip(
    message: 'Добавить услугу',
    child: OutlinedButton(
      onPressed: onTap,
      style: const ButtonStyle(
      ),
      child: const Icon(Icons.add, color: CupertinoColors.activeGreen),
    ),
  );
}