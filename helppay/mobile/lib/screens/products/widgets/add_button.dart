import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay_core/helppay_core.dart';

class AddButton extends StatelessWidget {
  final Function() onPressed;

  const AddButton({
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) => IconButton(
    icon: SvgPicture.asset(
      'assets/icon/accounts_add.svg'
    ),
    tooltip: context.t.mobileScreens.products.addButton,
    onPressed: onPressed
  );
}