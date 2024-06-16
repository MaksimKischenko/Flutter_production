import 'package:auto_route/auto_route.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/data/routing/routes.gr.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/screens/polls_list/widgets/widgets.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PollsListScreenBodyContent extends StatefulWidget {
  final List<Poll>? pollsList;
  final bool isListEmpty;
  final PollsListFiltersData filters;
  final int participantsCount;
  final int confirmedCount;
  final VoidCallback onFiltersTap;

  const PollsListScreenBodyContent({
    super.key,
    required this.pollsList,
    required this.isListEmpty,
    required this.filters,
    required this.participantsCount,
    required this.confirmedCount,
    required this.onFiltersTap,
  });

  @override
  State<PollsListScreenBodyContent> createState() =>
      _PollsListScreenBodyContentState();
}

class _PollsListScreenBodyContentState
    extends State<PollsListScreenBodyContent> {
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: WebConstrainedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (kIsWeb)
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 16, 4, 16),
                  child: WebTitleWidget(
                    onFiltersTap: widget.onFiltersTap,
                    status: widget.filters.status,
                  ),
                )
              else ...[
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 4, 16, 32),
                  child: PageTitle(
                    text: 'Голосования',
                    // text: context.t.screens.mdomPollsList.title
                  ),
                ),
                CurrentStatus(value: widget.filters.status),
              ],
              if (widget.isListEmpty && widget.pollsList != null)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(height: 32),
                    Text(
                      'Список пуст.\nВоспользуйтесь фильтром',
                      // context.t.screens.mdomPollsList.emptyDataMessage,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              if (!widget.isListEmpty)
                SlidableAutoCloseBehavior(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: widget.pollsList!.length,
                    itemBuilder: (context, index) => PollItem(
                      item: widget.pollsList![index],
                      onTap: (poll) => _onPollItemTap(
                          // participantsCount: participantsCount,
                          poll: poll),
                      onQuestionsListTap: _onPollQuestionsListTap,
                      onParticipantsListTap: _onPollParticipantsListTap,
                    ),
                    separatorBuilder: (context, _) => Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Divider(
                        color: AppStyles.mainTextColor.withOpacity(.5),
                        height: 1,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );

  void _onPollItemTap({
    required Poll poll,
  }) async {
    final filteredParticipantsCount = poll.status == PollStatus.completed
        ? (widget.pollsList
                ?.firstWhere((element) => element.id == poll.id)
                .participantsCount ??
            0)
        : widget.participantsCount;
    final filteredConfirmedCount = poll.status == PollStatus.completed
        ? (widget.pollsList
                ?.firstWhere((element) => element.id == poll.id)
                .confirmedCount ??
            0)
        : widget.confirmedCount;

    final value = await AutoRouter.of(context).push<Poll>(PollRoute(
      participantsCount: filteredParticipantsCount,
      confirmedCount: filteredConfirmedCount,
      poll: poll,
    ));

    // final value = await Navigation.toPoll(
    //   participantsCount: widget.participantsCount,
    //   confirmedCount: widget.confirmedCount,
    //   poll: poll,
    // );
    if (value != null) {
      final pollIndex = widget.pollsList!.indexWhere((e) => e.id == value.id);
      setState(() {
        widget.pollsList![pollIndex] = value;
      });
    }
  }

  void _onPollQuestionsListTap(
    Poll poll,
  ) {
    AutoRouter.of(context).push(
      PollStatisticsRoute(
        participantsCount: widget.participantsCount,
        confirmedCount: widget.confirmedCount,
        poll: poll,
      ),
    );
    // Navigation.toPollStatistics(
    //   participantsCount: widget.participantsCount,
    //   confirmedCount: widget.confirmedCount,
    //   poll: poll,
    // );
  }

  void _onPollParticipantsListTap(
    Poll poll,
  ) {
    AutoRouter.of(context).push<Poll>(
      PollRoute(
        poll: poll,
        confirmedCount: widget.confirmedCount,
        participantsCount: widget.participantsCount,
      ),
    );
    // Navigation.toPollMembers(
    //   context: context,
    //   poll: poll,
    //   confirmedCount: widget.confirmedCount,
    //   participantsCount: widget.participantsCount,
    // );
  }
}
