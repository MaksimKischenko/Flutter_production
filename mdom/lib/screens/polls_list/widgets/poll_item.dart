import 'package:bpc/data/data.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PollItem extends StatelessWidget {
  final Poll item;
  final Function(Poll poll) onTap;
  final Function(Poll poll) onQuestionsListTap;
  final Function(Poll poll) onParticipantsListTap;
  
  const PollItem({
    Key? key,
    required this.item,
    required this.onTap,
    required this.onQuestionsListTap,
    required this.onParticipantsListTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Slidable(
    closeOnScroll: true,
    endActionPane: ActionPane(
      motion: const ScrollMotion(),
      dragDismissible: false,
      children: [
        if (item.questions?.isNotEmpty ?? false)
        SlidableAction(
          label: 'Вопросы',
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xffFFB037),
          autoClose: false,
          onPressed: (_) => onQuestionsListTap(item),
        ),
        SlidableAction(
          label: 'Участники',
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xffC931FF),
          autoClose: false,
          onPressed: (_) => onParticipantsListTap(item),
        )
      ],
    ),
    child: GestureDetector(
      onTap: () => onTap(item),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              item.topic,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                letterSpacing: 0.1
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${item.startDate?.toStringWithoutSeconds() ?? ""} - ${item.stopDate?.toStringWithoutSeconds() ?? ""}',
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Column(
                  children: [
                   if (item.notificationDate != null)
                    Row(
                      children: [
                        const Icon(
                            Icons.notifications_outlined,
                            size: 14,
                            color: Color(0xff8E8E93),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2, right: 10),
                          child: Text(
                            item.notificationDate!,
                            style: const TextStyle(
                              color: Color(0xff8E8E93),
                              fontSize: 13
                            )
                          ),
                        ),
                      ],
                    ),
                    if (item.cancelDate != null)
                    Row(
                      children: [
                        const Icon(
                          Icons.block_rounded,
                          size: 14,
                          color: Color(0xff8E8E93),
                        ),
                        if (item.cancelDate != null) 
                        Padding(
                          padding: const EdgeInsets.only(left: 2, right: 10),
                          child: Text(
                            item.cancelDate!,
                            style: const TextStyle(
                              color: Color(0xff8E8E93),
                              fontSize: 13
                            )
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Text(
                    item.anonymous == 1
                        ? 'Закрытое'
                        : 'Открытое',
                    style: const TextStyle(
                      color: Color(0xff8E8E93),
                      fontSize: 13
                    )
                  ),
                ),
                Text(
                  item.status.name
                )
              ],
            )
          ],
        ),
      ),
    ),
  );

}