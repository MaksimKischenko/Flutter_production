import 'package:flutter/material.dart';
import 'package:web_cabinet_nkfo/styles.dart';

class EditButton extends StatelessWidget {
  final Function() onTap;

  const EditButton({
    required this.onTap
  });

  @override
  Widget build(BuildContext context) => Tooltip(
    message: 'Редактировать организацию',
    child: OutlinedButton(
      onPressed: onTap,
      style: const ButtonStyle(
      ),
      child: const Icon(Icons.edit, size: 20, color: AppStyles.mainColor)
    ),
  );
}