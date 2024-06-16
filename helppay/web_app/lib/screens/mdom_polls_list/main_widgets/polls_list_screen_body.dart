

import 'package:auto_route/auto_route.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/blocs/blocs.dart';
import 'package:helppay_web_app/routing/routes.gr.dart';
import 'package:helppay_web_app/screens/mdom_polls_list/widgets/notification_button.dart';
import 'package:helppay_web_app/screens/mdom_polls_list/widgets/widgets.dart';
import 'package:helppay_web_app/screens/mdom_polls_list_filters/widgets/widgets.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/utils/utils.dart';
import 'package:helppay_web_app/widgets/date_picker_widget.dart';
import 'package:helppay_web_app/widgets/widgets.dart';


// void _log(dynamic message) =>
//     Logger.helpPayLog(message, name: 'web_mdom_pols_list');

class MdomPollsListScreenBody extends StatefulWidget {
  final int supplierId;
  final int accountsCount;
  final String supplierTitle;

  const MdomPollsListScreenBody({
    required this.supplierId,
    required this.accountsCount,
    required this.supplierTitle,
    Key? key,
  }) : super(key: key);

  @override
  State<MdomPollsListScreenBody> createState() =>
      _MdomPollsListScreenBodyState();
}

class _MdomPollsListScreenBodyState extends State<MdomPollsListScreenBody> {
  int _tempId = 0;

  PollsListFiltersData filters = PollsListFiltersData.initial();

  List<Poll>? _pollsList;
  late int notificationCounter = 0;
  late int participantsCount = 0;
  int _pollsCount = CoreConfig.pollsListRequestLoadCount;
  bool get isListEmpty => _pollsList?.isEmpty ?? true;
  bool isLoadMoreAvailable = false;

  DateTime? dateFrom;
  DateTime? dateTo;

  //For waiting token
  @override
  void initState() {
    super.initState();
    final currentAuthState = context.read<AuthBloc>().state;
    if (currentAuthState is AuthAuthorized) {
      _onLoadPoolsInfo(widget.supplierId);
    } else {
      context.read<AuthBloc>().stream.listen((authState) {
        if (authState is AuthAuthorized) {
          _onLoadPoolsInfo(widget.supplierId);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: const CabinetMenu(selectedIndex: 0),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white),
        body: BlocListener<MdomPollsListBloc, MdomPollsListState>(
          listener: (context, state) {
            if (state is MdomPollsListError) {
            } else if (state is MdomPollsListErrorKomplat) {
              RequestUtil.catchKomplatError(
                context: context,
                errorCode: state.errorCode,
                errorText: state.errorMessage,
              );
              if (state.errorCode == 403) {
                Future.delayed(
                    const Duration(seconds: 2),
                    () => AutoRouter.of(context).pushAndPopUntil(AuthRoute(),
                        predicate: (route) => false));
              }
            } else if (state is MdomPollsListLoaded) {
              participantsCount = state.participantsCount;
              setState(() {
                notificationCounter = state.notificationsUnreadCount;
              });
              _successLoaded(state.polls);
              _pollsCount = state.polls.length;
              _pollsCount = _pollsCount + CoreConfig.pollsListRequestLoadCount;
            } else if (state is MdomPollsListLoadedMore) {
              _pollsCount = _pollsCount + CoreConfig.pollsListRequestLoadCount;
              _successLoadedMore(state.polls);
            }
          },
          child: SafeArea(
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
                          padding: const EdgeInsets.symmetric(horizontal: 28),
                          child: Text(
                            widget.supplierTitle,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppStyles.supplierTitleColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () => AutoRouter.of(context)
                                        .popAndPush(const MdomAccrualsRoute()),
                                    child: const Icon(
                                      Icons.arrow_back,
                                      size: 20,
                                      color: AppStyles.mainColor,
                                    )),
                                const SizedBox(width: 8),
                                PageTitle(
                                    text: context
                                        .t.mobileScreens.mdomPollsList.title),
                              ],
                            ),
                            NotificatioButton(
                              notificationCount: notificationCounter,
                              supplierId: widget.supplierId,
                              supplierTitle: widget.supplierTitle,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        StatusPicker(
                            value: filters.status, onChange: _onStatusChange),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              WebDatePicker(
                                initialDate: filters.stopDateFrom,
                                labelText: 'с',
                                onChange: (value) {
                                  setState(() {
                                    dateFrom = value;
                                    filters = filters.copyWith(
                                        stopDateFrom: dateFrom);
                                    _onLoadPoolsInfo(widget.supplierId);
                                  });
                                },
                                needValidation: false,
                              ),
                              const SizedBox(width: 4),
                              const Text('-'),
                              const SizedBox(width: 4),
                              WebDatePicker(
                                initialDate: filters.stopDateTo,
                                labelText: 'по',
                                onChange: (value) {
                                  setState(() {
                                    dateTo = value;
                                    filters =
                                        filters.copyWith(stopDateTo: dateTo);
                                    _onLoadPoolsInfo(widget.supplierId);
                                  });
                                },
                                needValidation: false,
                              ),
                            ],
                          ),
                        ),
                        if (isListEmpty && _pollsList != null)
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 32),
                                Text(
                                  context.t.mobileScreens.mdomPollsList
                                      .emptyDataMessage,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
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
                        if (isLoadMoreAvailable)
                          Center(
                            child: NoSplashButton(
                              withAddIcon: false,
                              text:
                                  context.t.widgets.refreshFooter.statuses.idle,
                              onTap: () => _onLoadMorePulled(widget.supplierId),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  void _onLoadPoolsInfo(int supplierId) {
    context
        .read<MdomPollsListBloc>()
        .add(MdomPollsListInit(filters: filters, supplierId: supplierId));
  }

  void _successLoaded(List<Poll> polls) {
    if (polls.length < CoreConfig.pollsListRequestLoadCount) {
      isLoadMoreAvailable = false;
    } else {
      setState(() {
        isLoadMoreAvailable = true;
      });
    }
    polls.sort((a, b) {
      final aDate = a.stopDate.toDateFormatted();
      final bDate = b.stopDate.toDateFormatted();
      return bDate.compareTo(aDate);
    });

    setState(() {
      _pollsList = List.from(polls);
    });
  }

  void _onStatusChange(PollStatus value) {
    setState(() {
      filters = filters.copyWith(
          status: value, stopDateFrom: dateFrom, stopDateTo: dateTo);
    });
    context.read<MdomPollsListBloc>().add(
        MdomPollsListInit(filters: filters, supplierId: widget.supplierId));
  }

  void _onLoadMorePulled(int supplierId) {
    final lastPollId = _pollsList!.last.id;
    context.read<MdomPollsListBloc>().add(MdomPollsListLoadMore(
        lastPollId: lastPollId, count: _pollsCount, supplierId: supplierId));
  }

  void _successLoadedMore(List<Poll> polls) {
    if (polls.isEmpty) {
      isLoadMoreAvailable = false;
    } else {
      isLoadMoreAvailable = true;

      if (polls.last.id == _tempId) {
        isLoadMoreAvailable = false;
      }
      _tempId = polls.last.id;

      for (final poll in polls) {
        if (_pollsList!.firstOrNullWhere(
                (e) => e.id == poll.id && e.account == poll.account) ==
            null) {
          _pollsList!.add(poll);
        }
      }
      setState(() {});
    }
  }

  // ignore: avoid_void_async
  void _onPollItemTap({
    required Poll poll,
  }) async {
    final value = await AutoRouter.of(context).push<Poll>(MdomPollRoute(
      participantsCount: participantsCount,
      poll: poll,
      supplierTitle: widget.supplierTitle,
    ));
    if (value != null) {
      final pollIndex = _pollsList!.indexWhere((e) => e.id == value.id && e.account == value.account);
      setState(() {
        _pollsList![pollIndex] = value;
      });
      _onLoadPoolsInfo(widget.supplierId);
    }
  }
}
