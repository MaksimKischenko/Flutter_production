import 'package:flutter/material.dart';

import 'package:web_cabinet_nkfo/styles.dart';

class BlockGroupAction extends StatelessWidget {

  final bool isAvailable;
  final Function() onTap;

  const BlockGroupAction({
     required this.onTap,
     this.isAvailable = false,
  }); 

  @override
  Widget build(BuildContext context) => Tooltip(
    message: 'Заблокировать',
    child: IconButton(
         splashRadius: 1,
         onPressed: isAvailable ? onTap : null, 
         icon: const Icon(Icons.lock),
         disabledColor: AppStyles.mainTextColor.withOpacity(0.5),
         color: AppStyles.mainColor,
    ),
  );

    
 
}