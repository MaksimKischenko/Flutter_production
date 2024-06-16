import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/injection_component.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/widgets/date_picker_widget.dart';
import 'package:helppay_web_app/widgets/web_dialog_window.dart';

import 'widgets/widgets.dart';

@RoutePage()
class PaymentsHistoryFiltersScreen extends StatefulWidget {
  static const PageInfo<dynamic> routePage =
      PageInfo('/payment_history_filters');

  static const pageRoute = '/payment_history/filters';

  final PaymentsHistoryFiltersScreenArgs? data;

  const PaymentsHistoryFiltersScreen({
    required this.data,
  });

  @override
  _PaymentsHistoryFiltersScreenState createState() =>
      _PaymentsHistoryFiltersScreenState();
}

class _PaymentsHistoryFiltersScreenState
    extends State<PaymentsHistoryFiltersScreen> {
  late DataManager _dataManager;

  final _dateFormKey = GlobalKey<FormState>();
  DateTime? dateFrom;
  DateTime? dateTo;

  var _productsList = <MdomLoginResponseProductsCurrent>[];

  DateTime get initialDateFrom =>
      DateTime.now().subtract(const Duration(days: 14));
  DateTime get initialDateTo => DateTime.now();
  MdomLoginResponseProductsCurrent? get initialProduct =>
      _dataManager.mainProduct;

  MdomLoginResponseProductsCurrent? _selectedProduct;

  @override
  void initState() {
    super.initState();

    _dataManager = InjectionComponent.getDependency<DataManager>();
    _productsList = _dataManager.userProducts?.current ?? [];
    _selectedProduct = widget.data?.selectedProduct ?? initialProduct;
    dateFrom = widget.data?.dateFrom.toDateFormatted();
    dateTo = widget.data?.dateTo.toDateFormatted();
  }

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return WebDialogWindow(
      titleActionWidget: TextButton(
        onPressed: _onResetTap,
        child: Text(context.t.mobileScreens.paymentsHistoryFilters.resetButton),
      ),
      title: context.t.mobileScreens.paymentsHistoryFilters.title,
      onPressed: _onApplyTap,
      buttonActive: true,
      buttonTitle: context.t.mobileScreens.paymentsHistoryFilters.applyButton,
      useSpacer: true,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        children: [
          Text(
            context.t.mobileScreens.paymentsHistoryFilters.periodTitle,
            style: TextStyle(
              color: AppStyles.mainColorDark.withOpacity(0.6),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 21),
          Form(
            key: _dateFormKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                WebDatePicker(
                  initialDate: dateFrom,
                  labelText: 'с',
                  onChange: (value) {
                    setState(() {
                      dateFrom = value;
                    });
                  },
                ),
                const SizedBox(width: 4),
                const Text('-'),
                const SizedBox(width: 4),
                WebDatePicker(
                  initialDate: dateTo,
                  labelText: 'по',
                  onChange: (value) {
                    setState(() {
                      dateTo = value;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            context.t.mobileScreens.paymentsHistoryFilters.productsTitle,
            style: TextStyle(
              color: AppStyles.mainColorDark.withOpacity(0.6),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          ProductsList(
            list: _productsList,
            groupValue: _selectedProduct,
            onTap: (product) {
              setState(() {
                _selectedProduct = product;
              });
            },
          ),
        ],
      ),
    );
  }

  void _onApplyTap() {
    print(dateFrom);
    if (_dateFormKey.currentState?.validate() ?? false) {
      _dateFormKey.currentState?.save();
      Navigator.of(context).pop<PaymentsHistoryFiltersScreenArgs>(
          PaymentsHistoryFiltersScreenArgs(
              dateFrom: dateFrom!.toStringFormatted(),
              dateTo: dateTo!.toStringFormatted(),
              selectedProduct: _selectedProduct));
    }
  }

  void _onResetTap() {
    dateFrom = initialDateFrom;
    dateTo = initialDateTo;
    _selectedProduct = initialProduct;
    setState(() {});
  }
}
