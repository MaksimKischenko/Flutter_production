
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppay_payform_app/styles.dart';

class AgainButton extends StatelessWidget {

  final Function() onTap;
  final String name;

  const AgainButton({
    Key? key,
    this.name = 'Заново',
    required this.onTap,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) => MaterialButton(
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
    shape: RoundedRectangleBorder(
      side: const BorderSide(
        color: AppStyles.mainColor
      ),
      borderRadius:BorderRadius.circular(6) 
    ),
    onPressed: onTap,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(CupertinoIcons.arrow_left, color: AppStyles.mainColor),
        SizedBox(width: 8),        
        Text( 
          name, 
           style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400, 
            color: AppStyles.mainColor
           )
        ),
      ],
    ),
  );
}
