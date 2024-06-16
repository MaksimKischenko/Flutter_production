import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

import 'widgets.dart';

class PollScreenBodyQuestionList extends StatelessWidget {
  final VotePollLoaded state;
  const PollScreenBodyQuestionList({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          ListTitle(
            poll: state.poll,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: state.questions.length,
            itemBuilder: (context, index) => QuestionItem(
              item: state.questions[index],
              status: state.poll.status,
              banChangeAnswer: state.poll.answerEditDisabled == 0,
              hideCurrentResult: state.poll.currentResultHiden == 0,
              voted: state.poll.voted == 1,
              onVoteTap: _onQuestionVoteTap,
            ),
            separatorBuilder: (context, _) => state.poll.voted == 1 ||
                    state.poll.status == PollStatus.publication
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                    ),
                    child: Separator(),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      );

  void _onQuestionVoteTap(
    PollListQuestion question,
    PollAnswer answer,
    BuildContext context,
  ) {
    context
        .read<VotePollBloc>()
        .add(VotePollAnswer(idx: question.idx, answer: answer));
  }
}
