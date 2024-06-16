import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/polls_list/polls_list_bloc.dart';
import 'package:bpc/config.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/data/routing/routes.gr.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/utils/utils.dart';
import 'package:bpc/widgets/refresh_footer.dart';
import 'package:bpc/widgets/refresh_header.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'main_widgets.dart';

class PollsListScreenBody extends StatefulWidget {
  final bool isAvaiable;
  final PollsListFiltersData filters;
  final ScrollController scrollController;
  final TextEditingController searchController;
  final VoidCallback onRefresh;
  final VoidCallback onFiltersTap;

  const PollsListScreenBody({
    super.key,
    required this.isAvaiable,
    required this.filters,
    required this.scrollController,
    required this.onRefresh,
    required this.searchController,
    required this.onFiltersTap,
  });

  @override
  State<PollsListScreenBody> createState() => _PollsListScreenBodyState();
}

class _PollsListScreenBodyState extends State<PollsListScreenBody> {
  int? participantsCount; //error with late initialisation acurred
  int? confirmedCount; //  and forced me to make this variable nullable
  List<Poll>? _pollsList;

  bool get isListEmpty => _pollsList?.isEmpty ?? true;

  late RefreshController refreshController;

  @override
  void initState() {
    super.initState();

    refreshController = RefreshController(initialRefresh: widget.isAvaiable);
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<PollsListBloc, PollsListState>(
        listener: (context, state) {
          if (state is PollsListError && state.actionType != null) {
            _catchErrorToRefreshController(state.actionType!);
          } else if (state is PollsListErrorKomplat &&
              state.actionType != null) {
            _catchErrorToRefreshController(state.actionType!);
            RequestUtil.catchKomplatError(
              context: context,
              errorCode: state.errorCode,
              errorText: state.errorMessage,
            );
            if (state.errorCode == 119) {
              Future.delayed(
                const Duration(seconds: 2),
                () => AutoRouter.of(context).push(const AuthRoute()),
              );
            }
          } else if (state is PollsListLoaded) {
            participantsCount = state.participantsCount;
            confirmedCount = state.confirmedCount;
            _successLoaded(state.polls);
          } else if (state is PollsListLoadedMore) {
            _successLoadedMore(state.polls);
          } else if (state is PollsListCancelPollSuccess) {
            _onCancelPoll(state.id);
          } else if (state is PollsListDeletePollSuccess) {
            _onDeletePoll(state.id);
          } else if (state is PollsListEditPollSuccess) {
            // _onEditPoll(state.poll);
            widget.onRefresh();
          }
        },
        child: SmartRefresher(
          scrollController: widget.scrollController,
          primary: false,
          controller: refreshController,
          onRefresh: widget.onRefresh,
          onLoading: _onLoadMorePulled,
          enablePullDown: true,
          enablePullUp: !isListEmpty,
          header: const RefreshHeader(),
          footer: const RefreshFooter(
            noMoreDataMessage: 'Голосований больше нет.',
            // TODO: localization
            // noMoreDataMessage: context.t.screens.mdomPollsList.noMoreDataMessage,
          ),
          child: PollsListScreenBodyContent(
            pollsList: _pollsList,
            isListEmpty: isListEmpty,
            filters: widget.filters,
            participantsCount: participantsCount ?? 0,
            confirmedCount: confirmedCount ?? 0,
            onFiltersTap: widget.onFiltersTap,
          ),
        ),
      );

  void _onLoadMorePulled() {
    final lastPollId = _pollsList!.last.id;

    context.read<PollsListBloc>().add(PollsListLoadMore(
          lastPollId: lastPollId,
        ));
  }

  void _catchErrorToRefreshController(ActionType actionType) {
    if (actionType == ActionType.refresh) {
      refreshController.refreshFailed();
    } else {
      refreshController.loadFailed();
    }
  }

  void _successLoaded(List<Poll> polls) {
    refreshController.resetNoData();

    if (polls.length < AppConfig.pollsListRequestLoadCount) {
      refreshController.loadNoData();
    }

    setState(() {
      _pollsList = List.from(polls);
      // _pollsList.followedBy(other)
      //_pollsList =  _pollsList?.where((element) => element.status == PollStatus.inProgress).toList();
      _pollsList
          ?.map((e) => e.stopDate?.toDateFormatted())
          .toList()
          .sort((a, b) => a!.compareTo(b!));
    });

    if (isListEmpty) {
      refreshController.refreshToIdle();
    } else {
      refreshController.refreshCompleted();
    }
  }

  void _successLoadedMore(List<Poll> polls) {
    if (polls.isEmpty) {
      refreshController.loadNoData();
    } else {
      if (polls.length < AppConfig.pollsListRequestLoadCount) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
      setState(() {
        _pollsList?.addAll(polls);
        _pollsList = _pollsList?.toSet().toList();
      });
    }
  }

  void _onCancelPoll(int id) {
    final pollIndex = _pollsList?.indexWhere((e) => e.id == id) ?? -1;

    if (pollIndex > -1) {
      setState(() {
        _pollsList![pollIndex] = _pollsList![pollIndex].copyWith(
          status: PollStatus.canceled,
          cancelDate: DateTime.now().toStringFormattedWithTime(),
        );
      });
    }
  }

  void _onDeletePoll(int id) {
    final pollIndex = _pollsList?.indexWhere((e) => e.id == id) ?? -1;

    if (pollIndex > -1) {
      setState(() {
        _pollsList!.removeAt(pollIndex);
      });
    }
  }

  void _onEditPoll(Poll poll) {
    final pollIndex = _pollsList?.indexWhere((e) => e.id == poll.id) ?? -1;

    if (pollIndex > -1) {
      setState(() {
        _pollsList![pollIndex] = poll;
      });
    }
  }
}
