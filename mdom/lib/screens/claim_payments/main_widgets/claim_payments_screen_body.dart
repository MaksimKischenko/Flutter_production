import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/data/routing/routes.gr.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/navigation.dart';
import 'package:bpc/utils/utils.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ClaimPaymentsScreenBody extends StatefulWidget {
  final ClaimPaymentsData data;
  const ClaimPaymentsScreenBody({
    super.key,
    required this.data,
  });

  @override
  State<ClaimPaymentsScreenBody> createState() =>
      _ClaimPaymentsScreenBodyState();
}

class _ClaimPaymentsScreenBodyState extends State<ClaimPaymentsScreenBody> {
  late ScrollController scrollController;
  late RefreshController refreshController;
  late PaymentsFilterData currentFilters;

  List<Payment> _paymentsList = [];
  bool get isListEmpty => _paymentsList.isEmpty;

  @override
  void initState() {
    scrollController = ScrollController();
    refreshController = RefreshController(initialRefresh: true);
    currentFilters = PaymentsFilterData(
      service: widget.data.service,
      dateType: PaymentDateType.receive,
      dateFrom: widget.data.dateFrom,
      dateTo: DateTime.now(),
      status: PaymentStatus.all,
      claimId: widget.data.claimId,
    );
    super.initState();
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
            RequestUtil.catchNetworkError(
              context: context,
              obj: state.error,
            );
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
            title: const Text('Платежи по требованию'),
          ),
          body: Scrollbar(
            controller: scrollController,
            child: SmartRefresher(
              scrollController: scrollController,
              controller: refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoadMorePulled,
              enablePullDown: true,
              enablePullUp: !isListEmpty,
              header: const RefreshHeader(),
              footer: const RefreshFooter(
                noMoreDataMessage: 'Платежей больше нет',
              ),
              child: isListEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Список пуст.\nВоспользуйтесь фильтром',
                            textAlign: TextAlign.center)
                      ],
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1),
                      itemCount: _paymentsList.length,
                      itemBuilder: (context, index) => PaymentItem(
                        item: _paymentsList[index],
                        onInfoClick: _openPaymentInfo,
                      ),
                    ),
            ),
          ),
        ),
      );

  void _onRefresh() {
    context.read<PaymentsBloc>().add(PaymentsLoad(filter: currentFilters));
  }

  void _onLoadMorePulled() {
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
    //This action must be disabled
    // AutoRouter.of(context).push(PaymentInfoRoute(payment: payment));

    // Navigation.toPaymentInfo(payment);
  }
}
