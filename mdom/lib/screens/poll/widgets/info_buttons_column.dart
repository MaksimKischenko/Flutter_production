import 'package:auto_route/auto_route.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/data/routing/routes.gr.dart';
import 'package:flutter/material.dart';

import 'widgets.dart';

class InfoButtonsColumn extends StatelessWidget {
  final Poll poll;
  final int confirmedCount;
  final int participantsCount;
  const InfoButtonsColumn({
    super.key,
    required this.poll,
    required this.confirmedCount,
    required this.participantsCount,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (poll.questions?.isNotEmpty ?? false)
            MainInfoItem(
              icon: Icons.list_rounded,
              text: 'Вопросы',
              trailingText: '${poll.questions!.length}',
              onTap: () => AutoRouter.of(context).push(
                PollStatisticsRoute(
                  participantsCount: participantsCount,
                  confirmedCount: confirmedCount,
                  poll: poll,
                ),
                //   Navigation.toPollStatistics(
                //     participantsCount: participantsCount,
                //     confirmedCount: confirmedCount,
                //     poll: poll,
                //   ),
              ),
            ),
          const SizedBox(height: 8),
          MainInfoItem(
            icon: Icons.people_outline_rounded,
            text: 'Участники',
            trailingText: '${participantsCount} / ${confirmedCount}',
            onTap: () => AutoRouter.of(context).push(
              PollMembersRoute(
                poll: poll,
                confirmedCount: confirmedCount,
                participantsCount: participantsCount,
              ),
            ),

            // Navigation.toPollMembers(
            //     context: context,
            //     poll: poll,
            //     confirmedCount: confirmedCount,
            //     participantsCount: participantsCount),
          ),
        ],
      );
}
