import 'package:bpc_nkfo/blocs/blocs.dart';
import 'package:bpc_nkfo/data/data.dart';
import 'package:bpc_nkfo/models/models.dart';
import 'package:bpc_nkfo/navigation.dart';
import 'package:bpc_nkfo/utils/utils.dart';
import 'package:bpc_nkfo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ClaimPaymentsScreen extends StatefulWidget {
  final ClaimPaymentsData info;

  const ClaimPaymentsScreen(this.info);
  
  @override
  _ClaimPaymentsScreenState createState() => _ClaimPaymentsScreenState();
}

class _ClaimPaymentsScreenState extends State<ClaimPaymentsScreen> {
  
  late PaymentsFilterData currentFilters;

  RefreshController refreshController = RefreshController(initialRefresh: true);

  List<Payment> _paymentsList = [];
  bool get isListEmpty => _paymentsList.isEmpty;

  @override
  void initState() {
    currentFilters = PaymentsFilterData(
      service: widget.info.service,
      dateType: 1,
      dateFrom: widget.info.dateFrom,
      dateTo: DateFormat('dd.MM.yyyy').format(DateTime.now()),
      claimId: widget.info.claimId
    );
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
      appBar: AppBar(
        title: const Text('Платежи по требованию'),
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