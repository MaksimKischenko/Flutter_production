import 'package:bpc/data/data.dart';
import 'package:bpc/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestionItem extends StatelessWidget {
  final PollListQuestion item;
  final bool isTapAvailable;
  final Function(PollListQuestion item, BuildContext context) onTap;

  const QuestionItem({
    Key? key,
    required this.item,
    required this.isTapAvailable,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => isTapAvailable ? onTap(item, context) : null,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffEAFDF9),
                  ),
                  child: Text(
                    '${item.idx}',
                    style: const TextStyle(
                      color: Color(0xff32C3A7),
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 10),
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
                            title: 'Да',
                            // TODO
                            // title: t.models.pollAnswer.voted.yes,
                            count: item.positiveCount ?? 0,
                          ),
                          const SizedBox(width: 32),
                          _answerCountItem(
                            title: 'Нет',
                            // TODO
                            // title: t.models.pollAnswer.voted.no,
                            count: item.negativeCount ?? 0,
                          ),
                          const SizedBox(width: 32),
                          _answerCountItem(
                            title: 'Воздерж.',
                            // TODO
                            // title: t.models.pollAnswer.voted.abstain,
                            count: item.abstainedCount ?? 0,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                if (isTapAvailable)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
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

  Widget _answerCountItem({required String title, required int count}) =>
      Column(
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
