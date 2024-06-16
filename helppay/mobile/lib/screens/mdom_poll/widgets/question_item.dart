import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class QuestionItem extends StatefulWidget {
  final PollListQuestion item;
  final PollStatus status;
  final bool voted;
  final bool banChangeAnswer;
  final bool hideCurrentResult;
  final Function(
          PollListQuestion question, PollAnswer answer, BuildContext context)
      onVoteTap;

  const QuestionItem({
    Key? key,
    required this.item,
    required this.status,
    required this.voted,
    required this.onVoteTap,
    this.banChangeAnswer = false,
    this.hideCurrentResult = false,
  }) : super(key: key);

  @override
  State<QuestionItem> createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.item.idx}.',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.item.value,
                    style: const TextStyle(fontSize: 18),
                  ),
                  if ((!widget.voted &&
                          widget.status == PollStatus.inProgress) ||
                      widget.banChangeAnswer)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: PollAnswer.values
                            .map(
                              (e) => InkWell(
                                onTap: () => widget.item.currentVote != e
                                    ? widget.onVoteTap(
                                        widget.item,
                                        e,
                                        context,
                                      )
                                    : null,
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: widget.item.currentVote == e
                                          ? const Color(0xffF1F3F8)
                                          : Colors.transparent,
                                      border: Border.all(
                                        color: widget.item.currentVote == e
                                            ? AppStyles.mainColor
                                            : AppStyles.mainTextColor
                                                .withOpacity(.1),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Text(
                                    e.nameActive,
                                    style: TextStyle(
                                      color: widget.item.currentVote == e
                                          ? AppStyles.mainColor
                                          : AppStyles.mainTextColor,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    )
                ],
              ),
            ),
            if (widget.voted &&
                !widget.banChangeAnswer &&
                widget.hideCurrentResult)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  widget.item.currentVote!.nameVoted,
                  style: TextStyle(
                    color: widget.item.currentVote!.color,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      );
}
