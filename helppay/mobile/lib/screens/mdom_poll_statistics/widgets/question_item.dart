import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class QuestionItem extends StatelessWidget {
  final PollListQuestion item;
  final Function(PollListQuestion item) onTap;
  final bool anonymous;

  const QuestionItem({
    Key? key,
    required this.item,
    required this.onTap,
    required this.anonymous,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () => anonymous ? null : onTap(item),
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
            offset: const Offset(0, 4)
          )
        ]
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${item.idx}.',
              style: const TextStyle(
                color: AppStyles.mainTextColor,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    item.value,
                    style: const TextStyle(
                      color: AppStyles.mainTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _answerCountItem(
                        title: t.models.pollAnswer.voted.yes,
                        count: item.positiveCount ?? 0,
                      ),
                      const SizedBox(width: 32),
                      _answerCountItem(
                        title: t.models.pollAnswer.voted.no,
                        count: item.negativeCount ?? 0,
                      ),
                      const SizedBox(width: 32),
                      _answerCountItem(
                        title: t.models.pollAnswer.voted.abstain,
                        count: item.abstainedCount ?? 0,
                      ),
                    ],
                  )
                ],
              ),
            ),
            if (!anonymous)
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.chevron_right,
                    color: Color(0xffC7C7CC),
                    size: 18,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _answerCountItem({
    required String title,
    required int count
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          color: AppStyles.mainTextColor.withOpacity(.5),
        ),
      ),
      Text(
        count.toString(),
        style: const TextStyle(
          color: AppStyles.mainTextColor,
          fontWeight: FontWeight.w500,
        ),
      )
    ],
  );
}