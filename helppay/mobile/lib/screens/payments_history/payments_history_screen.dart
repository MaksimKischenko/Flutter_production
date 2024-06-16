import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/blocs/blocs.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'widgets/widgets.dart';

class PaymentsHistoryScreen extends StatefulWidget {
  const PaymentsHistoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  _PaymentsHistoryScreenState createState() => _PaymentsHistoryScreenState();
}

class _PaymentsHistoryScreenState extends State<PaymentsHistoryScreen> {
  late ScrollController _hideBottomNavController;

  var _isVisible = true;

  var _historyList = <Payment>[];
  bool get isListEmpty => _historyList.isEmpty;

  final _titleKey = GlobalKey();

  double get titleSize => 40;
  bool _isTitleVisible = false;

  bool get _showTitle =>
      _hideBottomNavController.hasClients &&
      _hideBottomNavController.offset - titleSize > 0;

  RefreshController refreshController = RefreshController(initialRefresh: true);

  PaymentsHistoryFiltersScreenArgs? searchFilters;

  @override
  void initState() {
    super.initState();

    _hideBottomNavController = ScrollController();
    _hideBottomNavController.addListener(
      () {
        if (_isTitleVisible != _showTitle) {
          setState(() {
            _isTitleVisible = !_isTitleVisible;
          });
        }
        if (_hideBottomNavController.position.userScrollDirection ==
                ScrollDirection.reverse &&
            !isListEmpty) {
          if (_isVisible) {
            _isVisible = false;
            context.read<MenuBloc>().add(MenuHide());
          }
        }
        if (_hideBottomNavController.position.userScrollDirection ==
                ScrollDirection.forward &&
            !isListEmpty) {
          if (!_isVisible) {
            _isVisible = true;
            context.read<MenuBloc>().add(MenuShow());
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<PaymentsHistoryBloc, PaymentsHistoryState>(
          listener: (context, state) {
            if (state is PaymentsHistoryError) {
              _catchErrorToRefreshController(state.actionType);
              RequestUtil.catchNetworkError(context: context, obj: state.error);
            }
            if (state is PaymentsHistoryErrorKomplat) {
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
            }
            if (state is PaymentsHistorySuccessLoad) {
              _successLoad(state.list);
            }
            if (state is PaymentsHistorySuccessLoadMore) {
              _successLoadMore(state.list);
            }
          },
          child: Scaffold(
            // extendBody: true,
            appBar: AppBar(
              title: _showTitle
                  ? Text(
                      context.t.mobileScreens.paymentsHistory.title,
                      style: const TextStyle(
                        color: AppStyles.mainColorDark,
                      ),
                    )
                  : null,
              backgroundColor: Colors.transparent,
              actions: [
                FiltersButton(
                  onTap: _openFilters,
                )
              ],
            ),
            body: SmartRefresher(
              scrollController: _hideBottomNavController,
              controller: refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoadMorePulled,
              enablePullDown: true,
              enablePullUp: !isListEmpty,
              header: const RefreshHeader(),
              footer: RefreshFooter(
                noMoreDataMessage:
                    context.t.mobileScreens.paymentsHistory.noMoreDataMessage,
              ),
              child: isListEmpty
                  ? LayoutBuilder(
                      builder: (context, viewportConstraints) => ConstrainedBox(
                          constraints: BoxConstraints(
                              minHeight: viewportConstraints.maxHeight),
                          child: Stack(
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 4, 16, 32),
                                  child: PageTitle(
                                      key: _titleKey,
                                      text: context.t.mobileScreens
                                          .paymentsHistory.title)),
                              Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      context.t.mobileScreens.paymentsHistory
                                          .emptyDataMessage,
                                      textAlign: TextAlign.center))
                            ],
                          )),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
                              child: PageTitle(
                                  key: _titleKey,
                                  text: context
                                      .t.mobileScreens.paymentsHistory.title)),
                          PaymentsList(list: _historyList)
                        ],
                      ),
                    ),
            ),
          ));

  // ignore: avoid_void_async
  void _openFilters() async {
    final filters = await Navigation.toPaymentsHistoryFilters(
      context: context,
      data: searchFilters,
    );
    if (filters != null && searchFilters != filters) {
      searchFilters = filters;
      unawaited(refreshController.requestRefresh());
    }
  }

  void _onRefresh() {
    if (searchFilters?.selectedProduct != null) {
      context
          .read<PaymentsHistoryBloc>()
          .add(PaymentsHistoryLoad(searchFilters: searchFilters!));
    } else {
      refreshController.refreshToIdle();
    }
  }

  // ignore: avoid_void_async
  void _onLoadMorePulled() async {
    context.read<PaymentsHistoryBloc>().add(
        PaymentsHistoryLoadMore(lastPaymentId: _historyList.last.paymentId));
  }

  void _catchErrorToRefreshController(ActionType actionType) {
    if (actionType == ActionType.refresh) {
      refreshController.refreshFailed();
    } else {
      refreshController.loadFailed();
    }
  }

  void _successLoad(List<Payment> list) {
    refreshController.resetNoData();

    setState(() {
      _historyList = List.from(list);
    });

    if (isListEmpty) {
      refreshController.refreshToIdle();
    } else {
      refreshController.refreshCompleted();
    }
  }

  void _successLoadMore(List<Payment> addList) {
    if (addList.isEmpty) {
      refreshController.loadNoData();
    } else {
      setState(() {
        _historyList.addAll(addList);
      });
      refreshController.loadComplete();
    }
  }
}
