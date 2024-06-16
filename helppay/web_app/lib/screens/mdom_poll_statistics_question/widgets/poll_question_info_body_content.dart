import 'package:flutter/material.dart';
import 'package:helppay_core/blocs/mdom_poll_question_info/mdom_poll_question_info_bloc.dart';
import 'package:helppay_core/generated/translations.g.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

import 'widgets.dart';

class PollQuestionInfoBodyContent extends StatelessWidget {
  final MdomPollQuestionInfoLoaded state;
  const PollQuestionInfoBodyContent({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (state.positiveAnswers.isNotEmpty)
            ListTitle(
              context
                  .t.mobileScreens.mdomPollStatisticsQuestion.answersTitle.yes,
            ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            itemCount: state.positiveAnswers.length,
            itemBuilder: (context, index) => AnswerItem(
              item: state.positiveAnswers[index],
            ),
            separatorBuilder: (context, _) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Separator(),
            ),
          ),
          if (state.negativeAnswers.isNotEmpty)
            ListTitle(
              context
                  .t.mobileScreens.mdomPollStatisticsQuestion.answersTitle.no,
            ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            itemCount: state.negativeAnswers.length,
            itemBuilder: (context, index) => AnswerItem(
              item: state.negativeAnswers[index],
            ),
            separatorBuilder: (context, _) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Separator(),
            ),
          ),
          if (state.abstainAnswers.isNotEmpty)
            ListTitle(
              context.t.mobileScreens.mdomPollStatisticsQuestion.answersTitle
                  .abstain,
            ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            itemCount: state.abstainAnswers.length,
            itemBuilder: (context, index) => AnswerItem(
              item: state.abstainAnswers[index],
            ),
            separatorBuilder: (context, _) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Separator(),
            ),
          ),
        ],
      );
}
