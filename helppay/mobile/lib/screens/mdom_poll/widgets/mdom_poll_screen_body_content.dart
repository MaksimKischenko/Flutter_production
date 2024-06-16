import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets.dart';

class PollScreenBodyContent extends StatelessWidget {
  final int participantsCount;
  final Poll poll;
  final VotePollLoaded state;

  final ScrollController scrollController;
  const PollScreenBodyContent({
    super.key,
    required this.participantsCount,
    required this.poll,
    required this.state,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          Positioned.fill(
            bottom: ((state.poll.voted ?? 0) == 1 &&
                    state.poll.status == PollStatus.inProgress &&
                    !state.editMode)
                ? ButtonTheme.of(context).height * 2
                : ButtonTheme.of(context).height,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ExpandableText(
                      poll.topic,
                      expandText:
                          context.t.mobileScreens.mdomPoll.title.expandText,
                      collapseText:
                          context.t.mobileScreens.mdomPoll.title.collapseText,
                      maxLines: 3,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                        letterSpacing: -1,
                      ),
                      linkStyle: const TextStyle(
                          color: AppStyles.mainColor,
                          fontSize: 16,
                          letterSpacing: 0),
                    ),
                  ),
                  if (poll.url?.isNotEmpty ?? false) ...[
                    const SizedBox(height: 24),
                    LinkItem(value: poll.url!),
                  ],
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: InfoItem(
                      title: context.t.mobileScreens.mdomPoll.info.ending,
                      subtitle: poll.stopDate,
                    ),
                  ),
                  Separator(),
                  const SizedBox(height: 24),
                  PollScreenBodyQuestionList(state: state),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: PollScreenBodyButtons(
                state: state,
                poll: poll,
                participantsCount: participantsCount,
                isVoteButtonActive:
                    //  isVoteButtonActive
                    state.questions.length ==
                        state.questions
                            .where((e) => e.currentVote != null)
                            .length,
              ),
            ),
          ),
        ],
      );
}
