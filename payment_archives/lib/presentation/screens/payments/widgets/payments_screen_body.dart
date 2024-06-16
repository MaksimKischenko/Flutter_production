import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/routing/dialog_routes.dart';
import 'package:payment_tracking_module/presentation/screens/payments/listeners/listeners.dart';
import 'package:payment_tracking_module/presentation/screens/payments/widgets/table_action_bar.dart';
import 'package:payment_tracking_module/presentation/screens/payments/widgets/widgets.dart';
import 'package:payment_tracking_module/presentation/styles.dart';



class PaymentsScreenBody extends StatefulWidget {
  const PaymentsScreenBody({
    Key? key,
  }) : super(key: key); 

  @override
  State<PaymentsScreenBody> createState() => _PaymentsScreenBodyState();
}

class _PaymentsScreenBodyState extends State<PaymentsScreenBody> {
  late ScrollController _controller;
  late SearchPaymentData _requestData;
  final List<Payment> _selectedPayments = [];


@override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _requestData = SearchPaymentData.empty();
  }

@override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }  

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(20),
        child: MultiBlocListener(
          listeners: const [
            BlocListener<WebSocketBloc, WebSocketState>(
              listener: PaymentsListener.fromWebSocketsActions,
            ),
            BlocListener<SearchPaymentBloc, SearchPaymentState>(
              listener: PaymentsListener.fromPaymentsActions,
            ),
            BlocListener<FormReportsBloc, FormReportsState>(
              listener: PaymentsListener.uiFormReportsActions,
            ),
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text('Платежи', style: AppStyles.headerStyle)
              ),
              const SizedBox(height: 12),
              const PaymentsInfoCards(),
              TableActionBar(
                openFilters: _openFilters,
                selectedPayments: _selectedPayments,
              ),
              PaymentsTableWrapper(
                controller: _controller,
                selectedPayments: _selectedPayments,
                onSearchPayments: _onSearchPayments,
              )
            ],
          ),
        ),
      );

  Future<void> _openFilters(BuildContext context) async {
    final requestFilters = await DialogRoutes.toRequestFilters(context: context);
    if(requestFilters != null) {
      _requestData = requestFilters;
      await Future.delayed(const Duration(milliseconds: 50), () async => await _onSearchPayments());
    }
  }

  Future<void> _onSearchPayments() async{
    _refreshDataFiltersAndSelects();
    _initializeSearchFunctionality();
  }

  void _refreshDataFiltersAndSelects() {
    _selectedPayments.clear();
    BlocProvider.of<RowSelectedBloc<List<Payment>>>(context).add(RowSelectedRun<List<Payment>>(
      selectedData: SelectedData<List<Payment>>(isSelected: false, selectedObject: [])));
    context.read<SearchPaymentBloc>().add(SearchPaymentClearData());
  }

  void _initializeSearchFunctionality() {
    context.read<WebSocketBloc>().add(WebSocketInitialize());
    context.read<SearchPaymentBloc>().add(SearchPaymentInitialize(
      searchPaymentBody:  _requestData,
      searchPaymentMethod: _requestData.searchPaymentMethod ?? SearchPaymentMethod.full
    ));
  }
}
