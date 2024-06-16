import 'package:fl_qr_module/blocs/blocs.dart';
import 'package:fl_qr_module/styles.dart';
import 'package:flutter/cupertino.dart';

class QrTransactionReceipt extends StatelessWidget {
  final GetQRCheckDuplicateSuccess state;
  const QrTransactionReceipt({super.key, required this.state});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: state.receipt!.checkLine
              .map(
                (receiptLine) => receiptLine.lineValue != null
                    ? Text(
                        receiptLine.lineValue!.replaceAll('&apos;', "'"),
                        style: TextStyle(
                          color: AppStyles.mainTextColor.withOpacity(0.7),
                          fontSize: 16,
                        ),
                      )
                    : const SizedBox.shrink(),
              )
              .toList(),
        ),
      );
}
