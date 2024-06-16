import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

class PeriodItem extends StatelessWidget {
  final MdomPeriod period;
  final bool selected;
  final Function(MdomPeriod period) onTap;

  const PeriodItem({
    required this.period, 
    required this.selected, 
    required this.onTap
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => onTap(period),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Chip(
          labelStyle: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
            fontSize: 14,
            height: 20 / 14,
            color: selected ? const Color(0xff1E50A8) : Colors.black,
          ),
          label: Text(
            period.name,
          ),
          labelPadding:const EdgeInsets.symmetric(vertical: 4, horizontal: 22),
          backgroundColor: selected ? const Color(0xffF1F3F8) : Colors.white,
          side: BorderSide(
            color: selected ? AppStyles.mainColor : AppStyles.mainTextColor.withOpacity(.1),
            width: 1,
          ),
        ),
      ),
    );
}

