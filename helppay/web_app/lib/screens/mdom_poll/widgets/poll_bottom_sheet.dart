import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/routing/routes.gr.dart';
import 'package:helppay_web_app/screens/mdom_poll/widgets/widgets.dart';
import 'package:helppay_web_app/styles.dart';

class PollBottomSheet extends StatelessWidget {
  final int participantsCount;
  final Poll poll;
  final VotePollLoaded state;
  final bool isVoteButtonActive;

  const PollBottomSheet({
    super.key,
    required this.state,
    required this.isVoteButtonActive,
    required this.participantsCount,
    required this.poll,
  });

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (((state.poll.voted ?? 0) == 0 &&
                    state.poll.status == PollStatus.inProgress) ||
                state.editMode)
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      child: VoteButton(
                          editMode: state.editMode,
                          active: isVoteButtonActive,
                          onTap: _onVoteTap),
                    ),
                    TextButton(
                      onPressed: () => AutoRouter.of(context).back(),
                      child: const Text(
                        'Отмена',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppStyles.mainColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            if ((state.poll.voted ?? 0) == 1 &&
                state.poll.status == PollStatus.inProgress &&
                !state.editMode)
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state.poll.answerEditDisabled == 0)
                      SizedBox(
                        width: 200,
                        child: EditButton(onTap: _onEditTap),
                      ),
                    if (state.poll.currentResultHiden == 0)
                      if (((state.poll.voted ?? 0) == 1 &&
                              state.poll.status == PollStatus.inProgress &&
                              !state.editMode) ||
                          state.poll.status == PollStatus.completed)
                        PollStatButton(
                          status: state.poll.status,
                          votedCount: state.poll.votedCount ?? 0,
                          onTap: () => _onPollStatTap(context),
                          available: state.poll.votedCount != 0,
                        ),
                  ],
                ),
              ),
          ],
        ),
      );
  void _onVoteTap(BuildContext context) {
    context.read<VotePollBloc>().add(const VotePollProceedVote(
      increaseVoteCount: true
    ));
  }

  void _onEditTap(BuildContext context) {
    context.read<VotePollBloc>().add(VotePollEditVote());
  }

  void _onPollStatTap(BuildContext context) {
    AutoRouter.of(context).push<Poll>(MdomPollStatisticsRoute(
        participantsCount: participantsCount, poll: poll));
  }
}
