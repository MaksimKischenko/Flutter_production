import 'package:flutter/cupertino.dart';
import 'package:web_cabinet_nkfo/styles.dart';

class UndoButton extends StatelessWidget {
  final Function() onTap;

  const UndoButton({
    required this.onTap
  });
  
  @override
  Widget build(BuildContext context) => CupertinoButton(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    onPressed: onTap,
    color: AppStyles.mainColor,
    child: Text(
      'Отменить',
      style: AppStyles.buttonsWhiteTextStyle,
    )
  );
}
