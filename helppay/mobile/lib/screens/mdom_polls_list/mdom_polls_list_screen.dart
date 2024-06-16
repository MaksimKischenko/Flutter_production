import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay/screens/mdom_polls_list/widgets/notification_button.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'widgets/widgets.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'mdom_pols_list');

class MdomPollsListScreen extends StatefulWidget {
  static const pageRoute = '/polls';

  final int supplierId;
  final int accountsCount;
  final String? supplierTitle;

  const MdomPollsListScreen({
    Key? key,
    required this.supplierId,
    required this.accountsCount,
    this.supplierTitle,
  }) : super(key: key);

  @override
  State<MdomPollsListScreen> createState() => _MdomPollsListScreenState();
}

class _MdomPollsListScreenState extends State<MdomPollsListScreen> {
  late ScrollController _scrollController;
  int _tempId = 0;

  PollsListFiltersData filters = PollsListFiltersData.initial();

  RefreshController refreshController = RefreshController(initialRefresh: true);

  List<Poll>? _pollsList;
  late int notificationCounter = 0;
  late int participantsCount = 0;
  int _pollsCount = CoreConfig.pollsListRequestLoadCount;
  bool get isListEmpty => _pollsList?.isEmpty ?? true;

  double get titleSize => 40;
  double? _currentScrollPosition;

  bool _isTitleVisible = false;

  bool get _showTitle =>
      _scrollController.hasClients && _scrollController.offset - titleSize > 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_isTitleVisible != _showTitle) {
        setState(() {
          _isTitleVisible = !_isTitleVisible;
        });
      }
      _currentScrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBody: true,
        appBar: AppBar(
          leadingWidth: 65,
          automaticallyImplyLeading: false,
          leading: ArrowBack(),
          title: _showTitle
              ? Text(
                  context.t.mobileScreens.mdomPollsList.title,
                  style: const TextStyle(color: AppStyles.mainColorDark),
                )
              : null,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          actions: [
            Row(
              children: [
                //if (CoreConfig.appFlavour == AppFlavour.mdom )
                NotificatioButton(
                  notificationCount: notificationCounter,
                  onNotificationsTap: _onNotificationsTap,
                  // supplierId: widget.supplierId,
                  // supplierTitle: widget.supplierTitle,
                ),
                FiltersButton(
                  onTap: _onFiltersTap,
                ),
              ],
            )
          ],
        ),
        body: BlocListener<MdomPollsListBloc, MdomPollsListState>(
          listener: (context, state) {
            if (state is MdomPollsListError) {
              _catchErrorToRefreshController(state.actionType);
            } else if (state is MdomPollsListErrorKomplat) {
              final isTokenError = state.errorCode == 403;
              _catchErrorToRefreshController(state.actionType);
              if (!isTokenError) {
                RequestUtil.catchKomplatError(
                  context: context,
                  errorCode: state.errorCode,
                  errorText: state.errorMessage,
                );
              }
              if (isTokenError) {
                // Future<void>.delayed(const Duration(seconds: 1),
                //     () => Navigation.navigatorKey.currentState?.pop());
                Multiplatform.onExpiredTokenScreenLock(context);
              }
            } else if (state is MdomPollsListLoaded) {
              participantsCount = state.participantsCount;
              setState(() {
                notificationCounter = state.notificationsUnreadCount;
              });
              _successLoaded(state.polls);

              _pollsCount = state.polls.length;
            } else if (state is MdomPollsListLoadedMore) {
              _pollsCount = _pollsCount + CoreConfig.pollsListRequestLoadCount;
              _successLoadedMore(state.polls);
            }
          },
          child: SmartRefresher(
            scrollController: _scrollController,
            primary: false,
            controller: refreshController,
            onRefresh: () {
              refresState();
              _log(
                  'polls notification count ${context.read<MdomPollsListBloc>().state.participantsCount}');
            },
            onLoading: () => _onLoadMorePulled(widget.supplierId),
            enablePullDown: true,
            enablePullUp: !isListEmpty,
            header: const RefreshHeader(),
            footer: RefreshFooter(
              noMoreDataMessage:
                  context.t.mobileScreens.mdomPollsList.noMoreDataMessage,
              onTap: () => _onLoadMorePulled(widget.supplierId),
            ),
            child: SingleChildScrollView(
              //controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
                      child: PageTitle(
                          text: context.t.mobileScreens.mdomPollsList.title)),
                  CurrentStatus(value: filters.status),
                  if (isListEmpty && _pollsList != null)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 32),
                        Text(
                          context
                              .t.mobileScreens.mdomPollsList.emptyDataMessage,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  if (!isListEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemCount: _pollsList!.length,
                      itemBuilder: (context, index) => PollItem(
                        item: _pollsList![index],
                        onTap: (poll) => _onPollItemTap(poll: poll),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );


  void refresState() {
    context.read<MdomPollsListBloc>().add(MdomPollsListInit(filters: filters, supplierId: widget.supplierId));
  }

  // ignore: avoid_void_async
  void _onFiltersTap() async {
    final value = await Navigation.toMdomPollsListFilters(
      context: context,
      initialFilters: filters,
    );
    if (value != null) {
      filters = value;
      refresState();
    }
  }

  void _onNotificationsTap() async {
    final dynamic value = await Navigation.toMdomNotifications(
      supplierId: widget.supplierId,
      supplierTitle: widget.supplierTitle ?? '',
    );
    
    if (value != null) {
      context.read<MdomPollsListBloc>().add(
            MdomPollsListGetNotificationCount(
              supplierId: widget.supplierId,
              participantsCount:
                  context.read<MdomPollsListBloc>().state.participantsCount,
              polls: context.read<MdomPollsListBloc>().state.polls,
            ),
          );
    }
  }


  // ignore: avoid_void_async
  void _onPollItemTap({
    required Poll poll,
  }) async {
 
    final value = await Navigation.toMdomPoll(
      participantsCount: participantsCount,
      poll: poll,
    );

    if (value != null) {
      //final pollIndex = _pollsList!.indexWhere((e) => e.id == value.id && e.account == value.account);
      // setState(() {
      //   _pollsList![pollIndex] = value;
      // });
      // for (var obj in _pollsList ?? []) {
      //   if(obj.id == value.id) {
      //     final i = _pollsList?.indexOf(obj);
      //     obj = obj.copyWith(voted: 0);
      //     _pollsList![i ?? 0] = obj;
      //   }
      // }      
      refresState(); //KOMDEV-8913 - To avoid permanent changes of edited poll in the screens 
      _scrollController.jumpTo(_currentScrollPosition ?? 0);
    }
  }

  void _onLoadMorePulled(int supplierId) {
    final lastPollId = _pollsList!.last.id;
    context.read<MdomPollsListBloc>().add(MdomPollsListLoadMore(
        lastPollId: lastPollId, count: _pollsCount, supplierId: supplierId));
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

    if (polls.length < CoreConfig.pollsListRequestLoadCount) {
      refreshController.loadNoData();
    }

    polls.sort((a, b) {
      final aDate = a.stopDate.toDateFormatted();
      final bDate = b.stopDate.toDateFormatted();
      return bDate.compareTo(aDate);
    });
    setState(() {
      _pollsList = List.from(polls);
    });

    if (isListEmpty) {
      refreshController.refreshToIdle();
    } else {
      refreshController.refreshCompleted();
    }
  }

  void _successLoadedMore(List<Poll> polls) {
    if (polls.isEmpty) {
      refreshController.loadNoData(); // Голосований больше нет
    } else {
      refreshController.loadComplete();

      if (polls.last.id == _tempId) {
        refreshController.loadNoData();
      }
      _tempId = polls.last.id;

      for (final poll in polls) {
        if (_pollsList!.firstOrNullWhere(
                (e) => e.id == poll.id && e.account == poll.account) ==
            null) {
          _pollsList!.add(poll);
        }
      }
      setState(() {
        // _pollsList!.addAll(polls);
      });
    }
  }

  // Future<void> _checkNotificationCount() async {
  //   try {
  //     final notificationList =
  //         await InjectionComponent.getDependency<DataManager>()
  //             .notifyListRequest(
  //       supplierId: widget.supplierId,
  //       rowCount: const NotifyListRequestRowCount(
  //         value: 100,
  //         id: 0,
  //       ),
  //     );
  //     setState(
  //       () => notificationCounter = notificationList.unreadCount ?? 0,
  //     );

  //     // ignore: avoid_catches_without_on_clauses
  //   } catch (error, _) {
  //     setState(() {
  //       notificationCounter = 0;
  //     });
  //   }
  // }
}
