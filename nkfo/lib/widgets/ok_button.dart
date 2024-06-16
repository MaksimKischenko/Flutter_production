import 'package:flutter/cupertino.dart';
import 'package:web_cabinet_nkfo/styles.dart';

class OkButton extends StatelessWidget {
  final Function() onTap;
  final bool isAvaible;

  const OkButton({
    required this.onTap,
    this.isAvaible = true
  });
  
  @override
  Widget build(BuildContext context) => CupertinoButton(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    onPressed: isAvaible ? onTap : null,
    color: AppStyles.mainColor,
    disabledColor: AppStyles.mainTextColor.withOpacity(0.5),
    child: Text(
      'Ок',
      style: AppStyles.buttonsWhiteTextStyle
    )
  );
}