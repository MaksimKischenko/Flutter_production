import 'package:auto_route/auto_route.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/data/routing/routes.gr.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'widgets.dart';

class PollStatisticQuestinList extends StatelessWidget {
  final Poll poll;
  final int confirmedCount;
  final int participantsCount;
  const PollStatisticQuestinList({
    super.key,
    required this.poll,
    required this.confirmedCount,
    required this.participantsCount,
  });

  @override
  Widget build(BuildContext context) => Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height - 60,
            maxWidth: 720,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 4, 16, 32),
                child: PageTitle(
                  text: 'Вопросы',
                  // TODO
                  // text: context.t.screens.mdomPollStatistics.title
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: RichText(
                  text: TextSpan(
                    text: 'Проголосовало / Подтверж. / Все: ',
                    // TODO
                    // text: '${context.t.screens.mdomPollStatistics.votedText} / ${context.t.screens.mdomPollStatistics.participantsText}: ',
                    style: TextStyle(
                      color: AppStyles.mainTextColor.withOpacity(.5),
                    ),
                    children: [
                      TextSpan(
                        text:
                            '${poll.votedCount ?? 0} / $confirmedCount / ${poll.status == PollStatus.completed ? poll.participantsCount : participantsCount}',
                        style: const TextStyle(
                          color: AppStyles.mainTextColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: poll.questions?.length ?? 0,
                  itemBuilder: (context, index) => QuestionItem(
                    item: poll.questions![index],
                    onTap: _onQuestionTap,
                    isTapAvailable: (poll.status == PollStatus.inProgress ||
                            poll.status == PollStatus.completed ||
                            poll.status == PollStatus.canceled) &&
                        poll.anonymous == 0,
                  ),
                  separatorBuilder: (context, _) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(
                      color: AppStyles.mainTextColor.withOpacity(.1),
                      height: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  void _onQuestionTap(PollListQuestion question, BuildContext context) {
    AutoRouter.of(context).push<Poll>(
      PollStatisticsQuestionRoute(
        pollId: poll.id,
        question: question,
      ),
    );
    // Navigation.toPollStatisticsQuestion(
    //   pollId: poll.id,
    //   question: question,
    // );
  }
}
