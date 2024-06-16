import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppay/injection_component.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets/widgets.dart';

class PaymentsHistoryFiltersScreen extends StatefulWidget {
  final PaymentsHistoryFiltersScreenArgs? data;
  final ScrollController scrollController;

  const PaymentsHistoryFiltersScreen({
    required this.data,
    required this.scrollController
  });

  @override
  _PaymentsHistoryFiltersScreenState createState() => _PaymentsHistoryFiltersScreenState();
}

class _PaymentsHistoryFiltersScreenState extends State<PaymentsHistoryFiltersScreen> {
  late DataManager _dataManager;

  final _dateFormKey = GlobalKey<FormState>(); 

  final _fromController = TextEditingController();
  final _toController = TextEditingController();

  var _productsList = <MdomLoginResponseProductsCurrent>[];

  String get initialDateFrom => DateTime.now().subtract(const Duration(days: 14)).toStringFormatted();
  String get initialDateTo => DateTime.now().toStringFormatted();
  MdomLoginResponseProductsCurrent? get initialProduct => _dataManager.mainProduct;

  MdomLoginResponseProductsCurrent? _selectedProduct;

  @override
  void initState() {
    super.initState();

    _dataManager = InjectionComponent.getDependency<DataManager>();

    _productsList = _dataManager.userProducts?.current ?? [];

    _fromController.text = widget.data?.dateFrom ?? initialDateFrom;
    _toController.text = widget.data?.dateTo ?? initialDateTo;
    _selectedProduct = widget.data?.selectedProduct ?? initialProduct;
  }

  @override
  void dispose() {
    super.dispose();

    _fromController.dispose();
    _toController.dispose();
  }
  
  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
    navigationBar: DialogTitleAction(
      text: context.t.mobileScreens.paymentsHistoryFilters.title,
      action: TextButton(
        onPressed: _onResetTap,
        child: Text(context.t.mobileScreens.paymentsHistoryFilters.resetButton),
      ),
    ),
    child: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: widget.scrollController,
              // physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      context.t.mobileScreens.paymentsHistoryFilters.periodTitle,
                      style: TextStyle(
                        color: AppStyles.mainColorDark.withOpacity(0.6),
                        fontSize: 16
                      ),
                    ),
                  ),
                  const SizedBox(height: 21),
                  Form(
                    key: _dateFormKey,
                    child: PeriodPicker(
                      fromController: _fromController,
                      toController: _toController,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 8),
                    child: Text(
                      context.t.mobileScreens.paymentsHistoryFilters.productsTitle,
                      style: TextStyle(
                        color: AppStyles.mainColorDark.withOpacity(0.6),
                        fontSize: 16
                      ),
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
            child: ApplyButton(
              onPressed: _onApplyTap,
            ),
          )
        ],
      ),
    ),
  );

  void _onApplyTap() {
    if (_dateFormKey.currentState?.validate() ?? false) {
      _dateFormKey.currentState?.save();
      Navigator.of(context).pop<PaymentsHistoryFiltersScreenArgs>(
        PaymentsHistoryFiltersScreenArgs(
          dateFrom: _fromController.text,
          dateTo: _toController.text,
          selectedProduct: _selectedProduct
        )
      );
    }
  }

  void _onResetTap() {
    _fromController.text = initialDateFrom;
    _toController.text = initialDateTo;
    _selectedProduct = initialProduct;

    setState(() {});
  }
}