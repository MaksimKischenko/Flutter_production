import 'package:flutter/material.dart';

class FeatureData {
  final String iconName;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const FeatureData({
    required this.iconName,
    required this.title,
    this.subtitle,
    required this.onTap,
  });
}
