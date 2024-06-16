import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const SettingsItem({
    required this.onTap,
    required this.text
  });

  @override
  Widget build(BuildContext context) => ListTile(
    onTap: onTap,
    title: Text(text),
    trailing: const Icon(
      Icons.chevron_right
    ),
  );
}