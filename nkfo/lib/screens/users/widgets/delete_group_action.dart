import 'package:flutter/material.dart';

import 'package:web_cabinet_nkfo/styles.dart';

class DeleteGroupAction extends StatelessWidget {

  final bool isAvailable;
  final Function() onTap;

  const DeleteGroupAction({
     required this.onTap,
     this.isAvailable = false,
  }); 

  @override
  Widget build(BuildContext context) => Tooltip(
    message: 'Удалить',
    child: IconButton(
         splashRadius: 1,
         onPressed: isAvailable ? onTap : null, 
         icon: const Icon(Icons.delete_forever),
         disabledColor: AppStyles.mainTextColor.withOpacity(0.5),
         color: AppStyles.mainColor,
    ),
  );

    
 
}