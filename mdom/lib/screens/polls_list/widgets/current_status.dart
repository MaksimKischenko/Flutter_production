import 'package:bpc/models/models.dart';
import 'package:bpc/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CurrentStatus extends StatelessWidget {
  final PollStatus value;

  const CurrentStatus({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: kIsWeb
            ? const EdgeInsets.all(0)
            : const EdgeInsets.symmetric(horizontal: 16),
        child: RichText(
          text: TextSpan(
              text: 'Статус: ',
              // text: '${context.t.screens.mdomPollsList.currentStatus.title}: ',
              style: TextStyle(color: AppStyles.mainTextColor.withOpacity(.5)),
              children: [
                TextSpan(
                    text: value.name,
                    style: const TextStyle(color: AppStyles.mainTextColor))
              ]),
        ),
      );
}
