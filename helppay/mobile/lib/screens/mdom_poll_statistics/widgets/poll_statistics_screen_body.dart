import 'package:flutter/material.dart';
import 'package:helppay/navigation.dart';

import 'package:helppay/styles.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets.dart';

class PollStatisticsScreenBody extends StatelessWidget {
  final int participantsCount;
  final Poll poll;
  final ScrollController scrollController;
  const PollStatisticsScreenBody({
    super.key,
    required this.participantsCount,
    required this.poll,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
                child: PageTitle(
                    text: context.t.mobileScreens.mdomPollStatistics.title)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: RichText(
                text: TextSpan(
                  text:
                      '${context.t.mobileScreens.mdomPollStatistics.votedText} / ${context.t.mobileScreens.mdomPollStatistics.participantsText}: ',
                  style: TextStyle(
                    color: AppStyles.mainTextColor.withOpacity(.5),
                  ),
                  children: [
                    TextSpan(
                      text: '${poll.votedCount} / $participantsCount',
                      style: const TextStyle(
                        color: AppStyles.mainTextColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: poll.questions?.length,
              itemBuilder: (context, index) => QuestionItem(
                item: poll.questions?[index] ??
                    const PollListQuestion(value: '', idx: 0),
                onTap: _onQuestionTap,
                anonymous: poll.anonymous == 1,
              ),
            ),
          ],
        ),
      );

  void _onQuestionTap(PollListQuestion question) {
    Navigation.toMdomPollStatisticsQuestion(
      pollId: poll.id,
      question: question,
    );
  }
}
