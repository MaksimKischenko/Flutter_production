import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/navigation.dart';

import 'package:helppay_core/helppay_core.dart';

import 'widgets.dart';

class PollScreenBodyButtons extends StatelessWidget {
  final int participantsCount;
  final Poll poll;
  final VotePollLoaded state;
  final bool isVoteButtonActive;
  const PollScreenBodyButtons({
    super.key,
    required this.state,
    required this.isVoteButtonActive,
    required this.participantsCount,
    required this.poll,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          if (((state.poll.voted ?? 0) == 0 &&
                  state.poll.status == PollStatus.inProgress) ||
              state.editMode)
            VoteButton(
              editMode: state.editMode,
              active: isVoteButtonActive,
              onTap: _onVoteTap,
            ),
          if (((state.poll.voted ?? 0) == 1) && state.poll.status == PollStatus.inProgress && state.poll.answerEditDisabled == 0)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: EditButton(
                onTap: _onEditTap,
              ),
            ),
          if (state.poll.currentResultHiden == 0)
            if (((state.poll.voted ?? 0) == 1 &&
                    state.poll.status == PollStatus.inProgress &&
                    !state.editMode) ||
                state.poll.status == PollStatus.completed)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: PollStatButton(
                  status: state.poll.status,
                  votedCount: state.poll.votedCount ?? 0,
                  onTap: _onPollStatTap,
                  available: state.poll.votedCount != 0,
                  // available: state.poll.anonymous == 0
                  //     && state.poll.votedCount != 0,
                ),
              )
        ],
      );

  void _onVoteTap(BuildContext context) {
    context.read<VotePollBloc>().add(
      const VotePollProceedVote(
      increaseVoteCount: true
    ));
  }

  void _onEditTap(BuildContext context) {
    context.read<VotePollBloc>().add(
    const VotePollProceedVote(
      increaseVoteCount: false
    ));
    //context.read<VotePollBloc>().add(VotePollEditVote());
  }

  void _onPollStatTap() {
    Navigation.toMdomPollStatistics(
        participantsCount: participantsCount, poll: poll);
  }
}
