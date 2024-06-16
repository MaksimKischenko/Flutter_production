import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

import 'widgets.dart';

class PollScreenBodyContent extends StatelessWidget {
  final int participantsCount;
  final Poll poll;
  final VotePollLoaded state;
  final String? supplierTitle;

  const PollScreenBodyContent({
    super.key,
    required this.participantsCount,
    required this.poll,
    required this.state,
    required this.supplierTitle,
  });

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 40),
          child: SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 720,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        '${supplierTitle ?? ''} > Голосование',
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppStyles.supplierTitleColor),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () => AutoRouter.of(context)
                                .pop(), //navigateBack(),  //TODO pop for saving filters data
                            child: const Icon(
                              Icons.arrow_back,
                              size: 20,
                              color: AppStyles.mainColor,
                            )),
                        const SizedBox(width: 8),
                        Expanded(child: PageTitle(text: poll.topic)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (poll.url != null) LinkItem(value: poll.url!),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '${context.t.mobileScreens.mdomPoll.info.ending}: ${poll.stopDate}',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppStyles.supplierTitleColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    PollScreenBodyQuestionList(state: state),
                    // const SizedBox(height: ),

                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 16, vertical: 8),
                    //     child: PollScreenBodyButtons(
                    //       state: state,
                    //       poll: poll,
                    //       participantsCount: participantsCount,
                    //       isVoteButtonActive:
                    //           //  isVoteButtonActive
                    //           state.questions.length ==
                    //               state.questions
                    //                   .where((e) => e.currentVote != null)
                    //                   .length,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
