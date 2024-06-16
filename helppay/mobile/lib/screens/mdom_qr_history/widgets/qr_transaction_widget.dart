import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class QrTransactionWidget extends StatelessWidget {
  final QRTransaction transaction;
  const QrTransactionWidget({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon( 
          Icons.check_circle,
          color: AppStyles.secondaryColor,
          size: 16,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Платёж ${transaction.transactionStatus}',
                style: const TextStyle(
                  color: AppStyles.mainColorDark,
                  // letterSpacing: -0.5
                  // fontSize: 14
                ),
              ),
              const SizedBox(height: 6),
              Text(
                transaction.transactionDate,
                style: TextStyle(
                  fontSize: 12,
                  color: AppStyles.mainColorDark.withOpacity(0.6),
                ),
              )
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '${transaction.amount.value}',
          style: const TextStyle(
            color: Color(0xffFF3B30),
            fontSize: 16
          ),
        ),
        if (transaction.transactionInfo != null)
          Text(
            transaction.transactionInfo!.replaceAll('&quot;', '"'),
            style: TextStyle(
              fontSize: 12,
              color: AppStyles.mainColorDark.withOpacity(0.6),
            ),
          )        
        else
          const SizedBox.shrink(),        
      ],
    ),
  );

  // @override
  // Widget build(BuildContext context) {
  //   final style = TextStyle(
  //     color: AppStyles.mainTextColor.withOpacity(0.7),
  //     fontSize: 12,
  //   );

  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
  //     child: SizedBox(
  //       width: MediaQuery.of(context).size.width - 12,
  //       height: 50,
  //       child: DecoratedBox(
  //         decoration: BoxDecoration(
  //           // border: Border.all(color: Colors.black),
  //           color: Colors.white,
  //           boxShadow: const [
  //             BoxShadow(
  //               color: Color.fromRGBO(43, 80, 161, 0.06),
  //               blurRadius: 25,
  //               // offset:  Offset(2, .2),
  //             ),
  //           ],
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //           child: Column(
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   if (transaction.transactionInfo != null)
  //                     Text(
  //                       transaction.transactionInfo!.replaceAll('&quot;', '"'),
  //                       style: style,
  //                     )
  //                   else
  //                     const Spacer(),
  //                   Text(
  //                     'Платёж ${transaction.transactionStatus}',
  //                     maxLines: 2,
  //                     style: style,
  //                   ),
  //                 ],
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text(
  //                     transaction.transactionDate,
  //                     style: style,
  //                   ),
  //                   Text(
  //                     '${transaction.amount.value}',
  //                     style: style,
  //                   ),
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
