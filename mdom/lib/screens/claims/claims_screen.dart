import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/data/routing/routes.gr.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/navigation.dart';
import 'package:bpc/screens/claims/widgets/widgets.dart';
import 'package:bpc/utils/utils.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


@RoutePage()
class ClaimsScreen extends StatefulWidget {
  static const pageRoute = '/claims';

  const ClaimsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ClaimsScreenState createState() => _ClaimsScreenState();
}

class _ClaimsScreenState extends State<ClaimsScreen> {
  late ScrollController scrollController;
  late RefreshController refreshController;

  ClaimsFilterData? loadFilters;

  List<Claim> _claimsList = [];
  bool get isListEmpty => _claimsList.isEmpty;

  bool get availableFeatures =>
      context.read<FeaturesBloc>().state.availableFeatures;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    refreshController = RefreshController(initialRefresh: true);
  }

  @override
  void dispose() {
    refreshController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<ClaimsBloc, ClaimsState>(
        listener: (context, state) {
          if (state is ClaimsInitial) {
            loadFilters = state.filter;
          } else if (state is ClaimsError) {
            if (state.actionType != null) {
              _catchErrorToRefreshController(state.actionType!);
            }
            RequestUtil.catchNetworkError(context: context, obj: state.error);
          } else if (state is ClaimsErrorKomplat) {
            if (state.actionType != null) {
              _catchErrorToRefreshController(state.actionType!);
            }
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
          } else if (state is ClaimsSuccessLoad) {
            _successLoad(state.list);
          } else if (state is ClaimsSuccessLoadMore) {
            _successLoadMore(state.list);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: kIsWeb ? true : Platform.isIOS,
            automaticallyImplyLeading: false,
            title: kIsWeb
                ? const WebCabinetMenu(selectedIndex: 0)
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
                            const Text('Требования'),
                            if (state.filter.service != null)
                              Text(
                                state.filter.service!.name,
                                style: const TextStyle(fontSize: 12),
                              )
                          ],
                        );
                      } else {
                        return const Text('Требования');
                      }
                    },
                  ),
            actions: !kIsWeb
                ? [
                    BlocBuilder<ClaimsBloc, ClaimsState>(
                      builder: (context, state) {
                        if (state is ClaimsInitial) {
                          return IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            tooltip: 'Новое требование',
                            onPressed: () => _checkAvailability(
                              onAvailable: () => Navigation.toNewClaim(
                                context: context,
                                initialService: state.filter.service,
                                filtersData: state.filter,
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    CheckQrButton(
                      onTap: () => _checkAvailability(
                        onAvailable: () => AutoRouter.of(context).push(
                          QrCamRoute(
                            initialDateFrom: DateTime.now().subtract(
                              const Duration(days: 30),
                            ),
                          ),
                        ),
                      ),
                    ),
                    BlocBuilder<ClaimsBloc, ClaimsState>(
                      builder: (context, state) {
                        if (state is ClaimsInitial) {
                          return IconButton(
                            icon: const Icon(Icons.filter_list),
                            tooltip: 'Открыть фильтр',
                            onPressed: () => _checkAvailability(
                              onAvailable: () => _openFilters(state.filter),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ]
                : [],
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
                noMoreDataMessage: 'Требований больше нет',
              ),
              child: WebConstrainedBox(
                child: Column(
                  children: [
                    if (kIsWeb)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4, 16, 4, 16),
                        child: WebTitleWidget(
                          openFilters: _openFilters,
                        ),
                      ),
                    if (isListEmpty)
                      const Text('Список пуст.\nВоспользуйтесь фильтром',
                          textAlign: TextAlign.center)
                    else
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              const Divider(height: 1),
                          itemCount: _claimsList.length,
                          itemBuilder: (context, index) => ClaimItem(
                            item: _claimsList[index],
                            // slidableController: slidableController,
                            onDismissed: (item) => setState(() {
                              _claimsList.remove(item);
                            }),
                            onClaimPaymentsTap: (item) => _openClaimPayments(
                              ClaimPaymentsData(
                                service: loadFilters!.service!,
                                dateFrom: item.invoiceDate.toDateFormatted(),
                                accNum: item.accNum.toString(),
                                claimId: item.id,
                              ),
                            ),
                            onDeleteTap: (id) => context
                                .read<ClaimsBloc>()
                                .add(ClaimsDeleteClaim(id)),
                            onInfoClick: (item) => AutoRouter.of(context).push(
                                ClaimInfoRoute(
                                    service: loadFilters!.service!,
                                    claim: item)),
                          ),
                        ),
                      ),
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
  void _openFilters(ClaimsFilterData currentFilters) async {
    final filters = await Navigation.toClaimsFilters(
      context: context,
      currentFilters: currentFilters,
    );
    if (filters != null && currentFilters != filters) {
      loadFilters = filters;
      unawaited(refreshController.requestRefresh());
    }
  }

  void _onRefresh() {
    context
        .read<ClaimsBloc>()
        .add(ClaimsLoad(filter: loadFilters ?? ClaimsFilterData.empty()));
  }

  void _onLoadMorePulled() {
    context
        .read<ClaimsBloc>()
        .add(ClaimsLoadMore(lastClaimId: _claimsList.last.id));
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

  void _openClaimInfo({
    required Claim claim,
    required Service service,
  }) {
    AutoRouter.of(context).push(ClaimInfoRoute(service: service, claim: claim));
  }

  void _openClaimPayments(ClaimPaymentsData data) {
    AutoRouter.of(context).push(ClaimPaymentsRoute(data: data));
  }
}
