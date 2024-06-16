import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/data/routing/routes.gr.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/navigation.dart';
import 'package:bpc/screens/payments/widgets/widgets.dart';
import 'package:bpc/utils/utils.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

@RoutePage()
class PaymentsScreen extends StatefulWidget {
  static const pageRoute = '/payments';

  const PaymentsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _PaymentsScreenState createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  late ScrollController scrollController;
  late RefreshController refreshController;

  PaymentsFilterData? loadFilters;

  var _paymentsList = <Payment>[];
  bool get isListEmpty => _paymentsList.isEmpty;

  bool get availableFeatures =>
      context.read<FeaturesBloc>().state.availableFeatures;

  @override
  void initState() {
    super.initState();
    refreshController = RefreshController(initialRefresh: true);
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    refreshController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<PaymentsBloc, PaymentsState>(
        listener: (context, state) {
          if (state is PaymentsError) {
            _catchErrorToRefreshController(state.actionType);
            RequestUtil.catchNetworkError(context: context, obj: state.error);
          } else if (state is PaymentsErrorKomplat) {
            _catchErrorToRefreshController(state.actionType);
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
          } else if (state is PaymentsSuccessLoad) {
            _successLoad(state.list);
          } else if (state is PaymentsSuccessLoadMore) {
            _successLoadMore(state.list);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: kIsWeb ? true : Platform.isIOS,
            automaticallyImplyLeading: false,
            title: kIsWeb
                ? const WebCabinetMenu(
                    selectedIndex: 1,
                  )
                : BlocBuilder<PaymentsBloc, PaymentsState>(
                    builder: (context, state) {
                      if (state is PaymentsInitial) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: kIsWeb
                              ? CrossAxisAlignment.center
                              : Platform.isIOS
                                  ? CrossAxisAlignment.center
                                  : CrossAxisAlignment.start,
                          children: [
                            const Text('Платежи'),
                            if (state.filter.service != null)
                              Text(
                                state.filter.service!.name,
                                style: const TextStyle(fontSize: 12),
                              )
                          ],
                        );
                      } else {
                        return const Text('Платежи');
                      }
                    },
                  ),
            actions: [
              if (!kIsWeb)
                BlocBuilder<PaymentsBloc, PaymentsState>(
                  builder: (context, state) {
                    if (state is PaymentsInitial) {
                      return IconButton(
                          icon: const Icon(Icons.filter_list),
                          tooltip: 'Открыть фильтр',
                          onPressed: () => _checkAvailability(
                                onAvailable: () => _openFilters(state.filter),
                              ));
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
            ],
          ),
          body: Scrollbar(
            controller: scrollController,
            child: SmartRefresher(
              scrollController: scrollController,
              primary: false,
              controller: refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoadMorePulled,
              enablePullDown: true,
              enablePullUp: !isListEmpty,
              header: const RefreshHeader(),
              footer: const RefreshFooter(
                noMoreDataMessage: 'Платежей больше нет',
              ),
              child: WebConstrainedBox(
                child: Column(
                  children: [
                    if (kIsWeb)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4, 16, 4, 16),
                        child: PaymentsWebTitleWidget(
                          openFilters: _openFilters,
                        ),
                      ),
                    if (isListEmpty)
                      const Text(
                        'Список пуст.\nВоспользуйтесь фильтром',
                        textAlign: TextAlign.center,
                      )
                    else
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              const Divider(height: 1),
                          itemCount: _paymentsList.length,
                          itemBuilder: (context, index) => PaymentItem(
                            item: _paymentsList[index],
                            onInfoClick: _openPaymentInfo,
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  void _checkAvailability({required VoidCallback onAvailable}) {
    if (availableFeatures) {
      onAvailable();
    } else {
      Multiplatform.showMessage<void>(
          context: context,
          title: 'Инфо',
          message: 'Данная функция Вам недоступна',
          type: DialogType.info);
    }
  }

  // ignore: avoid_void_async
  void _openFilters(PaymentsFilterData currentFilters) async {
    final filters = await Navigation.toPaymentsFilters(
      context: context,
      currentFilters: currentFilters,
    );
    if (filters != null && currentFilters != filters) {
      loadFilters = filters;
      unawaited(refreshController.requestRefresh());
    }
  }

  void _onRefresh() {
    context.read<PaymentsBloc>().add(PaymentsLoad(
          filter: loadFilters ?? PaymentsFilterData.empty(),
        ));
  }

  // ignore: avoid_void_async
  void _onLoadMorePulled() async {
    context
        .read<PaymentsBloc>()
        .add(PaymentsLoadMore(lastPaymentId: _paymentsList.last.id));
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
      _paymentsList = List.from(list);
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
        _paymentsList.addAll(addList);
      });
      refreshController.loadComplete();
    }
  }

  void _openPaymentInfo(Payment payment) {
    AutoRouter.of(context).push(PaymentInfoRoute(payment: payment));

    // Navigation.toPaymentInfo(payment);
  }
}
