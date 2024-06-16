import 'package:flutter/material.dart';
import 'package:payment_tracking_module/presentation/styles.dart';

class UserRoleItem extends StatelessWidget {

  final Function()? onTap;
  final String text;
  final bool selected;

  const UserRoleItem({
    required this.onTap,
    required this.text,
    this.selected = false
  });

  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: selected ? null : onTap,
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.all(const Color(0xffEDF6FF))
    ),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        border: selected ? const Border(
          bottom: BorderSide(
            color: AppStyles.colorDark3,
            width: 2
          )
        ) : null
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: selected? FontWeight.w600 : FontWeight.w300,
          color: AppStyles.mainTextColor
        ),
      ),
    ),
  );
}