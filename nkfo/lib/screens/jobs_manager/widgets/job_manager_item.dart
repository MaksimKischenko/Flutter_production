import 'package:flutter/material.dart';

class JobManagerItem extends StatelessWidget {
    
  final Color color;
  final String text;

  const JobManagerItem({
    required this.color,
    required this.text,
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) => SizedBox(
    height: 24,
    width: 24,
    child: Tooltip(
        message: text,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
  );
  
}
