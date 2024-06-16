import 'package:flutter/material.dart';

class FiltersButton extends StatelessWidget {
  final VoidCallback onTap;

  const FiltersButton({
    Key? key,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onTap,
    icon: const Icon(Icons.filter_list)
  );
}