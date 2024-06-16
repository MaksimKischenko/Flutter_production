import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

class ListTitle extends StatelessWidget {
  final Poll poll;

  const ListTitle({
    Key? key,
    required this.poll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        Text(
          context.t.mobileScreens.mdomPoll.questionsList.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppStyles.cabinetMenuTextColor
          ),
        ),
        const SizedBox(width: 16),
        if (poll.voted == 1
            && poll.status == PollStatus.inProgress)
        const Padding(
          padding: EdgeInsets.only(right: 8),
          child: Icon(
            Icons.check,
            color: Color(0xff05BF65),
            size: 18,
          ),
        ),
        if (poll.voted == 1
            && poll.status == PollStatus.inProgress)
        Text(
          context.t.mobileScreens.mdomPoll.questionsList.votedText,
          style: const TextStyle(
            color: Color(0xff05BF65),
          ),
        ),
        if (poll.status == PollStatus.publication)
        Text(
          context.t.mobileScreens.mdomPoll.questionsList.startText(date: poll.startDate),
          style: const TextStyle(
            color: Color(0xffFF5C00)
          ),
        ),
        if (poll.status == PollStatus.completed)
        Text(
          context.t.mobileScreens.mdomPoll.questionsList.completedText(date: poll.stopDate),
          style: const TextStyle(
            color: Color(0xff05BF65)
          ),
        ),
      ],
    ),
  );
}