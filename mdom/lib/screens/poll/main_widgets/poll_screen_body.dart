import 'package:bpc/data/data.dart';
import 'package:bpc/screens/poll/widgets/widgets.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

class PollScreenBody extends StatelessWidget {
  final int confirmedCount;
  final int participantsCount;
  final Poll poll;
  final ScrollController scrollController;

  const PollScreenBody({
    super.key,
    required this.scrollController,
    required this.confirmedCount,
    required this.participantsCount,
    required this.poll,
  });

  @override
  Widget build(BuildContext context) => WebConstrainedBox(
        child: Column(
          children: [
            Expanded(
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
                        expandText: 'показать',
                        // TODO
                        // expandText: context.t.screens.mdomPoll.title.expandText,
                        collapseText: 'свернуть',
                        // TODO
                        // collapseText: context.t.screens.mdomPoll.title.collapseText,
                        maxLines: 3,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          letterSpacing: -1,
                        ),
                        linkStyle: const TextStyle(
                          color: AppStyles.mainColor,
                          fontSize: 16,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    InfoButtonsColumn(
                      confirmedCount: confirmedCount,
                      participantsCount: participantsCount,
                      poll: poll,
                    ),
                    const SizedBox(height: 30),
                    PollInfoFields(
                      poll: poll,
                    ),
                  ],
                ),
              ),
            ),
            ActionButtonRow(
              poll: poll,
            ),
          ],
        ),
      );
}
