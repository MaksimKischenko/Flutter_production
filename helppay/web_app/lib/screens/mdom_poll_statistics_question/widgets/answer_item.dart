import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

class AnswerItem extends StatelessWidget {
  final QuestionAnswersListQuestionAnswer item;

  const AnswerItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                item.clientAccount ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16
                ),
              ),
              const SizedBox(height: 2),
              Text(
                item.fio ?? '',
                style: TextStyle(
                  color: AppStyles.mainTextColor.withOpacity(.5),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          item.evalue!.nameVoted,
          style: TextStyle(
            color: item.evalue!.color,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}