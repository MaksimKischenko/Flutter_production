import 'package:flutter/material.dart';

import 'models.dart';

class CabinetMenuItem {
  final Function() onTap;
  final IconData? icon;
  final String text;
  final MenuAvailableItem controlledItem;

  const CabinetMenuItem({
    required this.onTap,
    this.icon,
    required this.text,
    required this.controlledItem
  });
}