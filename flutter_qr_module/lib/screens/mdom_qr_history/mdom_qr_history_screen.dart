import 'package:fl_qr_module/blocs/blocs.dart';
import 'package:fl_qr_module/blocs/qr_history/qr_history_bloc.dart';
import 'package:fl_qr_module/data/data.dart';
import 'package:fl_qr_module/generated/translations.g.dart';
import 'package:fl_qr_module/models/models.dart';
import 'package:fl_qr_module/screens/mdom_qr_history/widgets/widgets.dart';
import 'package:fl_qr_module/styles.dart';
import 'package:fl_qr_module/utils/utils.dart';
import 'package:fl_qr_module/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class QrHistoryScreen extends StatefulWidget {
  static const pageRoute = '/qr_history';

  const QrHistoryScreen({Key? key}) : super(key: key);

  @override
  _QrHistoryScreenState createState() => _QrHistoryScreenState();
}

class _QrHistoryScreenState extends State<QrHistoryScreen> {
  late ScrollController _qrHistoryListController;
  final mockdata = [
    QRTransaction(
      paymentId: 77,
      requestId: 123,
      status: 1,
      transactionDate: '12.02.2023',
      transactionStatus: 'Confirmed',
      transactionInfo: 'Kek Kekov',
      amount: Amount(currency: 124, value: 12),
    ),
    QRTransaction(
      paymentId: 77,
      requestId: 123,
      status: 1,
      transactionDate: '12.02.2021',
      transactionStatus: 'Confirmed',
      transactionInfo: 'Kek lolov',
      amount: Amount(currency: 123, value: 11),
    ),
    QRTransaction(
      paymentId: 77,
      requestId: 123,
      status: 1,
      transactionDate: '12.02.2022',
      transactionStatus: 'Confirmed',
      transactionInfo: 'Kek lolov',
      amount: Amount(currency: 123, value: 10),
    ),
    QRTransaction(
      paymentId: 77,
      requestId: 123,
      status: 1,
      transactionDate: '12.02.2023',
      transactionStatus: 'Confirmed',
      transactionInfo: 'Kek lolov',
      amount: Amount(currency: 1, value: 14),
    ),
    QRTransaction(
      paymentId: 77,
      requestId: 123,
      status: 1,
      transactionDate: '12.02.2023',
      transactionStatus: 'Confirmed',
      transactionInfo: 'Kek lolov',
      amount: Amount(currency: 1, value: 14),
    ),
    QRTransaction(
      paymentId: 77,
      requestId: 123,
      status: 1,
      transactionDate: '12.02.2023',
      transactionStatus: 'Confirmed',
      transactionInfo: 'Kek lolov',
      amount: Amount(currency: 1, value: 14),
    ),
    QRTransaction(
      paymentId: 77,
      requestId: 123,
      status: 1,
      transactionDate: '12.02.2023',
      transactionStatus: 'Confirmed',
      transactionInfo: 'Kek lolov',
      amount: Amount(currency: 1, value: 14),
    ),
  ];
  final _dateFormKey = GlobalKey<FormState>();

  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  String get initialDateFrom =>
      DateTime.now().subtract(const Duration(days: 14)).toStringFormatted();
  String get initialDateTo => DateTime.now().toStringFormatted();

  @override
  void initState() {
    super.initState();
    _fromController.text = initialDateFrom;
    _toController.text = initialDateTo;
    _qrHistoryListController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    // _hideBottomNavController.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<QrHistoryBloc, QrHistoryState>(
        builder: (context, state) {
          Widget body = const SizedBox.shrink();

          if (state is QrHistoryError) {
            //RequestUtil.catchNetworkError(context: context, obj: state.error);
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => Multiplatform.showMessage(
                context: context,
                title: t.general.errorModal.title,
                message: t.exceptions.network,
                type: DialogType.error,
              ),
            );
          } else if (state is QrHistoryLoading) {
            body = const LoadingIndicator();
          } else if (state is QrHistoryErrorKomplat) {
            final isTokenError = state.errorCode == 403;

            if (!isTokenError) {
              RequestUtil.catchKomplatError(
                context: context,
                errorCode: state.errorCode,
                errorText: state.errorMessage,
              );
            }
          }
          if (state is GetQROperationSuccess) {
            // _log('lst of operations ${state.qrTransaction![0].paymentId}');
            body = state.qrTransaction != null
                ? ListView(
                    controller: _qrHistoryListController,
                    children: state.qrTransaction!
                        .map(
                          (transaction) => GestureDetector(
                            onTap: transaction.status.sign == -1
                                ? () {
                                    Multiplatform.showMessage(
                                      context: context,
                                      title: context.t.mobileScreens.qrPayment
                                          .historyDialogTitle,
                                      message:
                                          'Платёж ${transaction.transactionStatus.toLowerCase()}',
                                      type: DialogType.info,
                                    );
                                  }
                                : () {
                                    BlocProvider.of<QrHistoryBloc>(context).add(
                                      GetQRCheckDuplicateEvent(
                                        qrTransaction: state.qrTransaction,
                                        transactionsCount:
                                            state.transactionsCount,
                                        requestId: transaction.requestId,
                                        advancedInfoRequired: 0,
                                      ),
                                    );
                                  },
                            child: QrTransactionWidget(
                              transaction: transaction,
                            ),
                          ),
                        )
                        .toList(),
                  )
                : Center(
                    child:
                        Text(context.t.mobileScreens.qrPayment.historyIsEmpty));
          }
          if (state is GetQRCheckDuplicateSuccess) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => Multiplatform.showScrollableDialog<Widget>(
                context: context,
                builder: (context, controller) => QrTransactionReceipt(
                  state: state,
                ),
              ),
            );
          }
          return Scaffold(
            extendBody: true,
            appBar: AppBar(
              centerTitle: true,
              leading: ArrowBack(),
              title: Text(
                // context.t.mobileScreens.settings.title
                context.t.mobileScreens.qrPayment.tranferHistory,
                style: const TextStyle(color: AppStyles.mainColorDark),
              ),
              backgroundColor: Colors.transparent,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Form(
                  key: _dateFormKey,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .09,
                    child: PeriodPicker(
                      fromController: _fromController,
                      toController: _toController,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ApplyFilterButton(
                    onTap: () {
                      final _dateFromFormatted = DateFormat('dd.MM.yyyy')
                          .parse(_fromController.value.text);

                      final dateFrom = DateFormat('dd/MM/yyyy HH:mm:ss')
                          .format(_dateFromFormatted);

                      final _dateToFormatted = DateFormat('dd.MM.yyyy')
                          .parse(_toController.value.text);

                      final dateTo = DateFormat('dd/MM/yyyy HH:mm:ss').format(
                        _dateToFormatted.add(
                          const Duration(hours: 23, minutes: 59, seconds: 59),
                        ),
                      );

                      BlocProvider.of<QrHistoryBloc>(context).add(
                        GetQROperationEvent(
                          dateFrom: dateFrom,
                          dateTo: dateTo,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      context.t.mobileScreens.qrPayment.hitorySearchResult,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                Expanded(child: body),
              ],
            ),
          );
        },
      );
}
