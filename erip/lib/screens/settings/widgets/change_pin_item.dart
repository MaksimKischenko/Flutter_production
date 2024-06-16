import 'package:flutter/material.dart';

class ChangePinItem extends StatelessWidget {
  final Function() onTap;

  const ChangePinItem({
    required this.onTap
  });
  
  @override
  Widget build(BuildContext context) => ListTile(
    onTap: onTap,
    title: const Text('Изменить PIN-код'),
    trailing: const Icon(
      Icons.chevron_right
    )
  );
}