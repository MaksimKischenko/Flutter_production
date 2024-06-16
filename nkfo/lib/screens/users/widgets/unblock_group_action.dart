import 'package:flutter/material.dart';

import 'package:web_cabinet_nkfo/styles.dart';

class UnBlockGroupAction extends StatelessWidget {

  final bool isAvailable;
  final Function() onTap;

  const UnBlockGroupAction({
     required this.onTap,
     this.isAvailable = false,
  }); 

  @override
  Widget build(BuildContext context) => Tooltip(
    message: 'Разблокировать',
    child: IconButton(
         splashRadius: 1,
         onPressed: isAvailable ? onTap : null, 
         icon: const Icon(Icons.lock_open),
         disabledColor: AppStyles.mainTextColor.withOpacity(0.5),
         color: AppStyles.mainColor,
    ),
  );

    
 
}