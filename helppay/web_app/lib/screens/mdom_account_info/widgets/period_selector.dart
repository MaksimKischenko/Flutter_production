import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

class PeriodSelector extends StatelessWidget {
  final MdomPeriodWrapper period;
  final Function() onTap;
  final Function() onPrevTap;
  final Function() onNextTap;

  const PeriodSelector({
    required this.period,
    required this.onTap,
    required this.onPrevTap,
    required this.onNextTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (period.period == MdomPeriod.notSet) {
      return Container();
    } else {
      return Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (period.period != MdomPeriod.custom)
          IconButton(
            onPressed: onPrevTap,
            iconSize: 20,
            color: AppStyles.mainColor,
            icon: const Icon(Icons.arrow_back_ios),
          ),
          Expanded(
            child: InkWell(
              onTap: onTap,
              child: SizedBox(
                height: 48,
                child: Center(
                  child: Text(
                    period.name(LocaleSettings.currentLocale.languageTag),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppStyles.cabinetMenuTextColor
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (period.period != MdomPeriod.custom)
          IconButton(
            onPressed: onNextTap,
            iconSize: 20,
            color: AppStyles.mainColor,
            icon: const Icon(Icons.arrow_forward_ios),
          )
        ],
      );
    }
  }
}
