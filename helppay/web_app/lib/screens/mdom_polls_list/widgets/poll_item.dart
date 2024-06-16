import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

class PollItem extends StatelessWidget {
  final Poll item;
  final Function(Poll poll) onTap;

  const PollItem({
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => onTap(item),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: AppStyles.mainColor.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 4))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  if ((item.voted ?? 0) == 1 &&
                      item.status == PollStatus.inProgress)
                    const Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: Icon(
                        Icons.check,
                        color: Color(0xff05BF65),
                        size: 18,
                      ),
                    ),
                  if (item.status == PollStatus.inProgress)
                    Text(
                      (item.voted ?? 0) == 1
                          ? context.t.mobileScreens.mdomPollsList.pollItem
                              .votedText.yes
                          : context.t.mobileScreens.mdomPollsList.pollItem
                              .votedText.no,
                      style: TextStyle(
                          color: (item.voted ?? 0) == 1
                              ? const Color(0xff05BF65)
                              : const Color(0xffFF5C00)),
                    ),
                  if (item.status == PollStatus.publication)
                    Text(
                      context.t.mobileScreens.mdomPollsList.pollItem
                          .startText(date: item.startDate),
                      style: const TextStyle(color: Color(0xffFF5C00)),
                    ),
                  if (item.status == PollStatus.completed)
                    Text(
                      context.t.mobileScreens.mdomPollsList.pollItem
                          .completedText(date: item.stopDate),
                      style: const TextStyle(color: Color(0xff05BF65)),
                    ),
                  const Spacer(),
                  Text(
                    item.account,
                    style: TextStyle(
                      color: AppStyles.mainTextColor.withOpacity(.5),
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    CupertinoIcons.chevron_right,
                    color: Color(0xffC7C7CC),
                    size: 18,
                  )
                ],
              ),
              const SizedBox(height: 8),
              Text(
                item.topic,
                style: const TextStyle(
                  fontSize: 16,
                  // fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                    text:
                        '${context.t.mobileScreens.mdomPollsList.pollItem.endingText}: ',
                    style: TextStyle(
                      color: AppStyles.mainTextColor.withOpacity(.5),
                    ),
                    children: [
                      TextSpan(
                          text: item.stopDate,
                          style:
                              const TextStyle(color: AppStyles.mainTextColor))
                    ]),
              )
            ],
          ),
        ),
      );
}
