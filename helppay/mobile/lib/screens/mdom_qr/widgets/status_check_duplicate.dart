import 'package:flutter/cupertino.dart';
import 'package:helppay/blocs/blocs.dart';
import 'package:helppay/styles.dart';

class StatusSuccessTransactionReceipt extends StatelessWidget {
  final SuccessStatusCheckDuplicateAccuired state;
  const StatusSuccessTransactionReceipt({
    super.key,
    required this.state,
  });

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
