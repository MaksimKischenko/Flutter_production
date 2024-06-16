import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_cabinet_nkfo/styles.dart';

class DeleteMessageButton extends StatelessWidget {
  final Function() onTap;

  const DeleteMessageButton({
    required this.onTap
  });

  @override
  Widget build(BuildContext context) => OutlinedButton(
    
    onPressed: onTap,
    style: const ButtonStyle(
    ),
    child: const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.delete, color: CupertinoColors.systemRed),
        SizedBox(width: 8),
        Text('Удалить', style: TextStyle(color:  AppStyles.mainColor))
      ],
    ),
  );
}