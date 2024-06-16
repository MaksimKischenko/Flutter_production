

import 'package:flutter/material.dart';

import 'package:web_cabinet_nkfo/styles.dart';

class EnterButton extends StatelessWidget {

  final Function() onAuthTap;

  const EnterButton({
    required this.onAuthTap,
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) => MaterialButton(
    padding: const EdgeInsets.symmetric(vertical: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      onPressed: onAuthTap,
      color: AppStyles.mainColor,
      child: Text(
        'Войти',
        style: AppStyles.buttonsWhiteTextStyle
      )
    );
  }
