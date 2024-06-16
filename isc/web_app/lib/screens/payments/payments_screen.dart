import 'dart:async';


import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isc_web_app/blocs/blocs.dart';
import 'package:isc_web_app/data/data.dart';
import 'package:isc_web_app/models/models.dart';
import 'package:isc_web_app/navigation.dart';
import 'package:isc_web_app/routing/routes.gr.dart';
import 'package:isc_web_app/screens/payments/widgets/widgets.dart';
import 'package:isc_web_app/styles.dart';
import 'package:isc_web_app/utils/utils.dart';
import 'package:isc_web_app/widgets/widgets.dart';



@RoutePage()
class PaymentsISCScreen extends StatefulWidget {
  static const pageRoute = '/payments_isc';

  const PaymentsISCScreen({
    Key? key,
  }) : super(key: key);

  @override
  _PaymentsISCScreenState createState() => _PaymentsISCScreenState();
}

class _PaymentsISCScreenState extends State<PaymentsISCScreen> {
  late ScrollController scrollController;

  PaymentsFilterData? loadFilters;

  var _paymentsList = <PaymentISC>[];
  bool get isListEmpty => _paymentsList.isEmpty;
  bool isLoadMoreAvailable = true; 


  @override
  void initState() {
    super.initState();
    final currentAuthState = context.read<AuthBloc>().state;
      if (currentAuthState is AuthAuthorized) {
        WidgetsBinding.instance.addPostFrameCallback(
        (_) => _onLoad());   
    } else {
      context.read<AuthBloc>().stream.listen((authState) {
        if (authState is AuthAuthorized) {
          WidgetsBinding.instance.addPostFrameCallback(
          (_) => _onLoad());   
        }
      });
    }
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<PaymentsBloc, PaymentsState>(
        listener: (context, state) {
          if(state is PaymentsInitial) {
            loadFilters = state.filter;
          }
          if (state is PaymentsError) {
            RequestUtil.catchNetworkError(context: context, obj: state.error);
          } else if (state is PaymentsErrorKomplat) {
            RequestUtil.catchKomplatError(
              context: context,
              errorCode: state.errorCode,
              errorText: state.errorMessage,
            );
            if (state.errorCode == 119) {
              Future.delayed(
                const Duration(seconds: 2),
                () => AutoRouter.of(context).push(AuthRoute()),
              );
            }
          } else if (state is PaymentsSuccessLoad) {
            _successLoad(state.list);
          } else if (state is PaymentsSuccessLoadMore) {         
            isLoadMoreAvailable = state.isLoadMoreAvailable;             
            _successLoadMore(state.list);            
          }
        },
        child: Scaffold(
          backgroundColor: AppStyles.backgroundColor,          
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: const CabinetMenu(selectedIndex: 2),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: PaymentsWebTitleWidget(
                    openFilters: _openFilters,
                  ),                
                ),
                Expanded(
                  child: PaymentsTable(
                    payments: _paymentsList,
                  ),
                ),                   
              ],
            ),
          ),
          persistentFooterAlignment: AlignmentDirectional.center,
          persistentFooterButtons: [
            if(!isListEmpty && isLoadMoreAvailable)
            SizedBox(
              width: 180,
              child: LoadMoreButton(
                text: 'Загрузить еще',
                onTap: _onLoadMore
              ),
            ) else 
              const SizedBox(height: 40)
          ],
          //bottomSheet: Container(),
        ),
      );


  Future<void> _openFilters(PaymentsFilterData currentFilters) async {
    final filters = await Navigation.toPaymentsFilters(
      context: context,
      currentFilters: currentFilters,
    );
    if (filters != null && currentFilters != filters) {
      loadFilters = filters;
      _onLoad();
    }
  }

  void _onLoad() {
    context.read<PaymentsBloc>().add(PaymentsLoad(filter: loadFilters ?? PaymentsFilterData.empty()));
  }

  void _onLoadMore() {
    context.read<PaymentsBloc>().add(PaymentsLoadMore(lastPaymentId: _paymentsList.last.id));
  }


  void _successLoad(List<PaymentISC> list) {
    setState(() {
      _paymentsList = List.from(list);
    });
  }

  void _successLoadMore(List<PaymentISC> addList) {
    setState(() {
      _paymentsList.addAll(addList);
    });
    if(!isLoadMoreAvailable) {
      Multiplatform.showMessage(
        context: context,
        title: 'Успешно',
        message: 'Все платежи загружены',
        type: DialogType.success,
      ); 
    }   
  }
  

  void _openPaymentInfo(PaymentISC payment) {
     AutoRouter.of(context).push(PaymentInfoRoute(payment: payment));
   }
  }     

