import 'package:flutter/material.dart';

class DecoratedInfoContainer extends StatelessWidget {
    
  final Color color;
  final String text;

  const DecoratedInfoContainer({
    required this.color,
    required this.text,
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) => SizedBox(
    height: 14,
    width: 14,
    child: Tooltip(
        message: text,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            //borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
  );
}
