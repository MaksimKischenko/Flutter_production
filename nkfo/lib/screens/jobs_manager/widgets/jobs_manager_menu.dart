import 'package:flutter/material.dart';

import 'widgets.dart';

class JobsManagerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Row(
    children: [
      JobManagerItem(
        color: Colors.red, 
        text: 'Выполнено с ошибкой'
      ),
      SizedBox(width: 4),
      JobManagerItem(
        color: Colors.blue, 
        text: 'Выполняется'
      ),
      SizedBox(width: 4),
      JobManagerItem(
        color: Colors.green, 
        text: 'Выполнено успешно'
      ),
      SizedBox(width: 4),
      JobManagerItem(
        color: Colors.grey, 
        text: 'Выключено'
      ),
      SizedBox(width: 4),
      JobManagerItem(
        color: Colors.black, 
        text: 'Включено'
      ),
      SizedBox(width: 4),
    ],
  );
}