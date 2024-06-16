import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class CurrentStatus extends StatelessWidget {
  final PollStatus value;

  const CurrentStatus({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: RichText(
      text: TextSpan(
        text: '${context.t.mobileScreens.mdomPollsList.currentStatus.title}: ',
        style: TextStyle(
          color: AppStyles.mainTextColor.withOpacity(.5)
        ),
        children: [
          TextSpan(
            text: value.name,
            style: const TextStyle(
              color: AppStyles.mainTextColor
            )
          )
        ]
      ),
    ),
  );
}