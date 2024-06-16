class QrPaymentsHistoryArgs {
  final String dateFrom;
  final String dateTo;
  // final MdomLoginResponseProductsCurrent? selectedProduct;

  const QrPaymentsHistoryArgs({
    required this.dateFrom,
    required this.dateTo,
    // required this.selectedProduct
  });

  @override
  String toString() =>
      'PaymentsHistoryFiltersScreenArgs { dateFrom: $dateFrom, dateTo: $dateTo, selectedProduct: QR}';
}
