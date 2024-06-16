import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';

class FiltersButton extends StatelessWidget {
  final VoidCallback onTap;

  const FiltersButton({
    Key? key,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: onTap,
    child: Text(
      context.t.mobileScreens.mdomPollsList.filtersButton,
    ),
  );
}