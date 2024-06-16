import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:web_cabinet_nkfo/styles.dart';

class ActionButton extends StatelessWidget {
  
  final double widthSize;
  final Function() onTap;
  final String? name;
  final Map<String, Icon> icons = {
    'Добавить':  const Icon(CupertinoIcons.add_circled, color: AppStyles.mainColor, size: 20),
    'Удалить': const Icon(CupertinoIcons.delete, color: AppStyles.mainColor, size: 20),
    'Редактировать': const Icon(Icons.edit, color: AppStyles.mainColor, size: 20),
    'Выполнить': const Icon(Icons.checklist, color: AppStyles.mainColor, size: 20),
    'Загрузить еще': const Icon(Icons.download_outlined, color: AppStyles.mainColor, size: 20),
  };
    
  ActionButton({
    required this.onTap,
    this.widthSize = 140,
    this.name = 'Добавить',
  });

  
  @override
  Widget build(BuildContext context) => SizedBox(
    width: widthSize,
    child: MaterialButton(
      padding: const EdgeInsets.symmetric(vertical: 20),
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppStyles.mainColor),
          borderRadius: BorderRadius.circular(6)
      ),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icons['$name']!,
          const SizedBox(width: 13),
          Text(
            '$name',
            style: AppStyles.buttonsBlueTextStyle
          ),
        ],
      ),
    ),
  );
  
  
  // CupertinoButton(
  //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
  //   color: AppStyles.mainColor.withOpacity(0.3),
  //   onPressed: onTap,
  //   borderRadius: const BorderRadius.all(Radius.zero),
  //   child: Row(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       icons['$name']!,
  //       const SizedBox(width: 8),
  //       Text('$name', style: const TextStyle(color: Colors.black)),
  //     ],
  //   ),
  // );
}
