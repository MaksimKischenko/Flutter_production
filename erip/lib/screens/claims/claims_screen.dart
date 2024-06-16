import 'dart:async';
import 'dart:io';

import 'package:bpc_nkfo/blocs/blocs.dart';
import 'package:bpc_nkfo/data/data.dart';
import 'package:bpc_nkfo/models/models.dart';
import 'package:bpc_nkfo/navigation.dart';
import 'package:bpc_nkfo/screens/claims/widgets/widgets.dart';
import 'package:bpc_nkfo/screens/screens.dart';
import 'package:bpc_nkfo/utils/utils.dart';
import 'package:bpc_nkfo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ClaimsScreen extends StatefulWidget {
  final bool availableFeatures;
  final ClaimsFilterData initialFilters;

  const ClaimsScreen({
    required this.availableFeatures,
    required this.initialFilters
  });

  @override
  _ClaimsScreenState createState() => _ClaimsScreenState();
}

class _ClaimsScreenState extends State<ClaimsScreen> {

  late ClaimsFilterData currentFilters;

  RefreshController refreshController = RefreshController(initialRefresh: true);

  var _claimsList = <Claim>[];
  bool get isListEmpty => _claimsList.isEmpty;

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
  Widget build(BuildContext context) => BlocListener<ClaimsBloc, ClaimsState>(
    listener: (context, state) {
      if (state is ClaimsError) {
        if (state.actionType != null) _catchErrorToRefreshController(state.actionType!);
        RequestUtil.catchError(
          context,
          state.error
        );
      }
      if (state is ClaimsErrorKomplat) {
        if (state.actionType != null) _catchErrorToRefreshController(state.actionType!);
        RequestUtil.catchKomplatError(
          context: context,
          errorCode: state.errorCode,
          errorText: state.errorMessage
        );
      }
      if (state is ClaimsSuccessLoad) {
        _successLoad(state.list);
      }
      if (state is ClaimsSuccessLoadMore) {
        _successLoadMore(state.list);
      }
    },
    child: Scaffold(
      drawer: const BpcDrawer(isClaimsSelected: true),
      appBar: AppBar(
        centerTitle: Platform.isIOS,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: Platform.isIOS
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            const Text('Требования'),
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
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'Новое требование',
            onPressed: () {
              _checkAvailability(
                onAvailable: _openNewClaim
              );
            },
          ),
          CheckQrButton(
            onPressed: () {
              _checkAvailability(
                onAvailable: () => Navigation.toQrCam(
                  initialDateFrom: DateTime.now().subtract(const Duration(days: 30))
                )
              );
            },
          ),
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
            noDataMessage: 'Требований больше нет',
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
            itemCount: _claimsList.length,
            itemBuilder: (BuildContext context, int index) => ClaimItem(
              item: _claimsList[index],
              onDismissed: (item) => setState(() {
                _claimsList.remove(item);
              }),
              onClaimPaymentsTap: (item) {
                _openClaimPayments(ClaimPaymentsData(
                  service: currentFilters.service!,
                  dateFrom: item.invoiceDate,
                  accNum: item.accNum.toString(),
                  claimId: item.id
                ));
              },
              onDeleteTap: (id) => context.read<ClaimsBloc>().add(
                ClaimsDeleteClaim(id)
              ),
              onInfoClick: (item) => _openClaimInfo(item, currentFilters.service!)
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
      onAvailable.call();
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
    final filters = await Multiplatform.showScrollableDialog<ClaimsFilterData>(
      context: context,
      builder: (context, scrollController) => ClaimsFilterScreen(
        data: currentFilters,
        scrollController: scrollController,
      )
    );
    if (filters != null && currentFilters != filters) {
      setState(() {
        currentFilters = filters;
      });
      unawaited(refreshController.requestRefresh());
    }
  }

  void _onRefresh() {
    BlocProvider.of<ClaimsBloc>(context).add(
      ClaimsLoad(
        filter: currentFilters
      )
    );
  }

  void _onLoadMorePulled() {
    BlocProvider.of<ClaimsBloc>(context).add(
      ClaimsLoadMore(
        filter: currentFilters,
        lastClaimId: _claimsList.last.id
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

  void _successLoad(List<Claim> list) {
    refreshController.resetNoData();

    setState(() {
      _claimsList = List.from(list);
    });

    if (isListEmpty) {
      refreshController.refreshToIdle();
    } else {
      refreshController.refreshCompleted();
    }
  }

  void _successLoadMore(List<Claim> addList) {
    if (addList.isEmpty) {
      refreshController.loadNoData();
    } else {
      setState(() {
        _claimsList.addAll(addList);
      });
      refreshController.loadComplete();
    }
  }

  void _openNewClaim() {
    Navigation.toNewClaim(
      context: context,
      bloc: context.read<ClaimsBloc>(),
      initialService: currentFilters.service
    );
  }

  void _openClaimInfo(Claim claim, Service service) {
    Navigation.toClaimInfo(
      claim: claim,
      service: service
    );
  }

  void _openClaimPayments(ClaimPaymentsData data) {
    Navigation.toClaimPayments(data);
  }
}