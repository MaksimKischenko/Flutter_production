import 'package:helppay_core/data/data.dart';

class PaymentsHistoryFiltersScreenArgs {
  final String dateFrom;
  final String dateTo;
  final MdomLoginResponseProductsCurrent? selectedProduct;

  const PaymentsHistoryFiltersScreenArgs({
    required this.dateFrom,
    required this.dateTo,
    required this.selectedProduct
  });

  @override
  String toString() => 'PaymentsHistoryFiltersScreenArgs { dateFrom: $dateFrom, dateTo: $dateTo, selectedProduct: $selectedProduct}';
}