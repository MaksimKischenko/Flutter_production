import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';


class ServiceResultItem extends StatelessWidget {
  final String title;
  final dynamic subtitle;

  const ServiceResultItem({
    required this.title,
    this.subtitle
  });

  @override
  Widget build(BuildContext context) => Responsive(
    children: [
      Div(
        divison: const Division(
          colL: 3,
          colM: 12,              
        ),        
        child: Text(
          title,
          style: const TextStyle(
            color: Color(0xff172030),
            fontSize: 16,
            fontWeight: FontWeight.w400
          ),
        ),
      ),
      //const SizedBox(width: 8),
      Div(
        divison: const Division(
          colL: 9,
          colM: 12,              
        ),       
        child: Text(
          '$subtitle',
          style: const TextStyle(
            color: Color(0xff333333),
            fontSize: 16,
            fontWeight: FontWeight.bold
            // letterSpacing: -0.5
          ),
        ),
      ),
    ],
  );
}