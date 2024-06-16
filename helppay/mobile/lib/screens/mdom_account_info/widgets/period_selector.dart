import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';

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
      return InkWell(
        onTap: onTap,
        child: Container(
          // color: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  period.name(LocaleSettings.currentLocale.languageTag),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.2
                  ),
                )
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xffC7C7CC),
                size: 22,
              )
            ],
          ),
        ),
      );
    } else {
      return Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (period.period != MdomPeriod.custom)
          IconButton(
            onPressed: onPrevTap,
            iconSize: 20,
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
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.2
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
            icon: const Icon(Icons.arrow_forward_ios),
          )
        ],
      );
    }
  }
}
