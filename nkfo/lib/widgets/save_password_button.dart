import 'package:flutter/material.dart';
import 'package:web_cabinet_nkfo/styles.dart';

class SavePasswordButton extends StatelessWidget {
  final Function() onTap;

  const SavePasswordButton({
    required this.onTap
  });
  
  @override
  Widget build(BuildContext context) => MaterialButton(
    onPressed: onTap,
    color: AppStyles.mainColor,
    elevation: 0,
    highlightElevation: 0,
    child: Text(
      'Сохранить пароль',
      style: AppStyles.buttonsWhiteTextStyle
    )
  );
}