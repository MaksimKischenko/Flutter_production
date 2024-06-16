import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

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
  Widget build(BuildContext context) => InkWell(
      onTap: () => onTap(period),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            // width for check icon
            const SizedBox(width: 4, height: 24),
            Expanded(
              child: Text(
                period.name,
                style: const TextStyle(
                  color: AppStyles.mainColorDark,
                  fontSize: 16,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
            const SizedBox(width: 4),
            if (selected && period != MdomPeriod.custom)
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(
                Icons.check,
                color: AppStyles.mainColor,
                size: 24,
              ),
            ),
            if (period == MdomPeriod.custom)
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Color(0xffC7C7CC),
                size: 22,
              ),
            )
          ],
        ),
      ),
    );
}