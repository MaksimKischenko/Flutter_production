import 'dart:async';
import 'dart:io';

import 'package:bpc_nkfo/blocs/blocs.dart';
import 'package:bpc_nkfo/data/data.dart';
import 'package:bpc_nkfo/models/models.dart';
import 'package:bpc_nkfo/navigation.dart';
import 'package:bpc_nkfo/screens/screens.dart';
import 'package:bpc_nkfo/utils/utils.dart';
import 'package:bpc_nkfo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PaymentsScreen extends StatefulWidget {
  final bool availableFeatures;
  final PaymentsFilterData initialFilters;

  const PaymentsScreen({
    required this.availableFeatures,
    required this.initialFilters
  });

  @override
  _PaymentsScreenState createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  late PaymentsFilterData currentFilters;

  RefreshController refreshController = RefreshController(initialRefresh: true);

  var _paymentsList = <Payment>[];
  bool get isListEmpty => _paymentsList.isEmpty;

  @override
  void initState() {
    currentFilters = widget.initialFilters;
    super.initState();
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) => BlocListener<PaymentsBloc, PaymentsState>(
    listener: (context, state) {
      if (state is PaymentsError) {
        _catchErrorToRefreshController(state.actionType);
        RequestUtil.catchError(
          context,
          state.error
        );
      }
      if (state is PaymentsErrorKomplat) {
        _catchErrorToRefreshController(state.actionType);
        RequestUtil.catchKomplatError(
          context: context,
          errorCode: state.errorCode,
          errorText: state.errorMessage
        );
      }
      if (state is PaymentsSuccessLoad) {
        _successLoad(state.list);
      }
      if (state is PaymentsSuccessLoadMore) {
        _successLoadMore(state.list);
      }
    },
    child: Scaffold(
      drawer: const BpcDrawer(isPaymentsSelected: true),
      appBar: AppBar(
        centerTitle: Platform.isIOS,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: Platform.isIOS
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            const Text('Платежи'),
            if (currentFilters.service != null)
            Text(
              currentFilters.service!.name,
              style: const TextStyle(
                fontSize: 12
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            tooltip: 'Открыть фильтр',
            onPressed: () {
              _checkAvailability(
                onAvailable: _openFilters
              );
            }
          )
        ],
      ),
      body: Scrollbar(
        child: SmartRefresher(
          controller: refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoadMorePulled,
          enablePullDown: true,
          enablePullUp: !isListEmpty,
          header: RefreshHeader(),
          footer: const RefreshFooter(
            noDataMessage: 'Платежей больше нет',
          ),
          child: isListEmpty
          ? const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Список пуст.\nВоспользуйтесь фильтром',
                textAlign: TextAlign.center
              )
            ],
          )
          : ListView.separated(
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemCount: _paymentsList.length,
            itemBuilder: (BuildContext context, int index) => PaymentItem(
              item: _paymentsList[index],
              onInfoClick: _openPaymentInfo
            ),
          )
        ),
      ),
    ),
  );

  void _checkAvailability({
    required Function() onAvailable
  }) {
    if (widget.availableFeatures) {
      onAvailable();
    } else {
      Multiplatform.showMessage<void>(
        context: context,
        title: 'Инфо',
        message: 'Данная функция Вам недоступна',
        type: DialogType.info
      );
    }
  }

  // ignore: avoid_void_async
  void _openFilters() async {
    final filters = await Multiplatform.showScrollableDialog<PaymentsFilterData>(
      context: context,
      builder: (context, scrollController) => PaymentsFilterScreen(
        data: currentFilters,
        scrollController: scrollController,
      )
    );
    // PaymentsFilterData filters = await Navigator.of(context).push(
    //   MaterialPageRoute(builder: (context) =>
    //     PaymentsFilterScreen(filters: currentFilters),
    //     fullscreenDialog: true
    //   )
    // );
    if (filters != null && currentFilters != filters) {
      setState(() {
        currentFilters = filters;
      });
      unawaited(refreshController.requestRefresh());
    }
  }

  void _onRefresh() {
    BlocProvider.of<PaymentsBloc>(context).add(
      PaymentsLoad(
        filter: currentFilters
      )
    );
  }

  void _onLoadMorePulled() {
    BlocProvider.of<PaymentsBloc>(context).add(
      PaymentsLoadMore(
        filter: currentFilters,
        lastPaymentId: _paymentsList.last.id
      )
    );
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
    Navigation.toPaymentInfo(payment);
  }
}