import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/blocs/blocs.dart';
import 'package:helppay_web_app/navigation.dart';
import 'package:helppay_web_app/routing/routes.gr.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/utils/utils.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

import 'widgets/widgets.dart';

@RoutePage()
class PaymentsHistoryScreen extends StatefulWidget {
  static const PageInfo<dynamic> routePage = PageInfo('/payment_history');

  static const pageRoute = '/payment_history';
  const PaymentsHistoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  _PaymentsHistoryScreenState createState() => _PaymentsHistoryScreenState();
}

class _PaymentsHistoryScreenState extends State<PaymentsHistoryScreen> {
  var _historyList = <Payment>[];
  bool get isListEmpty => _historyList.isEmpty;

  PaymentsHistoryFiltersScreenArgs? searchFilters;

  @override
  void initState() {
    super.initState();
    final currentAuthState = context.read<AuthBloc>().state;
    if (currentAuthState is AuthAuthorized) {
      _onLoadHistoryInfo();
    } else {
      context.read<AuthBloc>().stream.listen((authState) {
        if (authState is AuthAuthorized) {
          _onLoadHistoryInfo();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<PaymentsHistoryBloc, PaymentsHistoryState>(
        listener: (context, state) {
          if (state is PaymentsHistoryError) {
            RequestUtil.catchNetworkError(context: context, obj: state.error);
          }
          if (state is PaymentsHistoryErrorKomplat) {
            RequestUtil.catchKomplatError(
                context: context,
                errorCode: state.errorCode,
                errorText: state.errorMessage);
            if (state.errorCode == 403) {
              Future.delayed(
                  const Duration(seconds: 2),
                  () => AutoRouter.of(context).pushAndPopUntil(AuthRoute(),
                      predicate: (route) => false));
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
          appBar: AppBar(
              title: const CabinetMenu(selectedIndex: 2),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white),
          body: isListEmpty
              ? SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 40),
                    child: Center(
                      child: LayoutBuilder(
                        builder: (context, viewportConstraints) =>
                            ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 720),
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 4, 16, 32),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            PageTitle(
                                                text: context.t.mobileScreens
                                                    .paymentsHistory.title),
                                            NoSplashButton(
                                                withAddIcon: false,
                                                onTap: _openFilters,
                                                text: context
                                                    .t
                                                    .mobileScreens
                                                    .paymentsHistory
                                                    .filterButton),
                                          ],
                                        )),
                                    Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                            context
                                                .t
                                                .mobileScreens
                                                .paymentsHistory
                                                .emptyDataMessage,
                                            textAlign: TextAlign.center))
                                  ],
                                )),
                      ),
                    ),
                  ),
                )
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 40),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PageTitle(
                                  text: context
                                      .t.mobileScreens.paymentsHistory.title,
                                ),
                                GestureDetector(
                                  onTap: _openFilters,
                                  behavior: HitTestBehavior.translucent,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      context.t.mobileScreens.paymentsHistory
                                          .filterButton,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: AppStyles.mainColor,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          PaymentsList(list: _historyList)
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      );

  // ignore: avoid_void_async
  void _openFilters() async {
    final filters = await Navigation.toPaymentHistory(
        context: context, data: searchFilters);

    // AutoRouter.of(context).push<PaymentsHistoryFiltersScreenArgs>(
    //   PaymentsHistoryFiltersRoute(
    //     data: searchFilters,
    //   )
    // );
    if (filters != null && searchFilters != filters) {
      searchFilters = filters;
    }
  }

  void _onLoadHistoryInfo() {
    if (searchFilters?.selectedProduct != null) {
      context
          .read<PaymentsHistoryBloc>()
          .add(PaymentsHistoryLoad(searchFilters: searchFilters!));
    }
  }

  // ignore: avoid_void_async
  //TODO implement this
  // void _onLoadMorePulled() async {
  //   context.read<PaymentsHistoryBloc>().add(
  //       PaymentsHistoryLoadMore(lastPaymentId: _historyList.last.paymentId));
  // }

  void _successLoad(List<Payment> list) {
    setState(() {
      _historyList = List.from(list);
    });
  }

  void _successLoadMore(List<Payment> addList) {
    setState(() {
      _historyList.addAll(addList);
    });
  }
}
