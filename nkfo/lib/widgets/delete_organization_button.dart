import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteOrganizationButton extends StatelessWidget {
  final Function() onTap;

  const DeleteOrganizationButton({
    required this.onTap
  });

  @override
  Widget build(BuildContext context) => Tooltip(
    message: 'Удалить организацию',
    child: OutlinedButton(
      onPressed: onTap,
      style: const ButtonStyle(
      ),
      child: const Icon(Icons.delete, color: CupertinoColors.systemRed),
    ),
  );
}