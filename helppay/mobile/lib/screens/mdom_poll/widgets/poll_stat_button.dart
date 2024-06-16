import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class PollStatButton extends StatelessWidget {
  final PollStatus status;
  final int votedCount;
  final VoidCallback onTap;
  final bool available;

  const PollStatButton({
    Key? key,
    required this.votedCount,
    required this.onTap,
    required this.available,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: available ? onTap : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              votedCount == 0 && status == PollStatus.completed
                  ? context.t.mobileScreens.mdomPoll.pollsStatButtonNoOneVoted
                  : votedCount == 0 && status == PollStatus.inProgress
                      ? context.t.mobileScreens.mdomPoll
                          .pollsStatButtonNoOneVotedYeat
                      : context.t.mobileScreens.mdomPoll
                          .pollStatButton(n: votedCount, count: votedCount),
              // 'blabla $votedCount',
              style: const TextStyle(
                color: AppStyles.mainColor,
                fontSize: 16,
              ),
            ),
            if (available)
              const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Icon(
                  CupertinoIcons.chevron_right,
                  color: AppStyles.mainColor,
                ),
              )
          ],
        ),
      );
}
