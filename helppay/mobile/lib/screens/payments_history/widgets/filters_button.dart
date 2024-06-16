import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay_core/helppay_core.dart';

class FiltersButton extends StatelessWidget {
  final Function() onTap;

  const FiltersButton({
    required this.onTap
  });

  @override
  Widget build(BuildContext context) => IconButton(
      icon: SvgPicture.asset(
        'assets/icon/filters.svg'
      ),
      tooltip: context.t.mobileScreens.paymentsHistory.filterButton,
      onPressed: onTap
    );
}