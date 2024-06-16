import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:intl/intl.dart';

class PaymentItem extends StatelessWidget {
  final PaymentBilling item;
  // final Function(PaymentBilling item) onInfoClick;

  const PaymentItem({
    required this.item,
    // required this.onInfoClick,
  });

  @override
  Widget build(BuildContext context) {
    final paymentDate = DateFormat(item.datePay.length > 10 ? 'dd/MM/yyyy HH:mm:ss' : 'dd/MM/yyyy').parse(item.datePay);
    return ListTile(
      contentPadding:const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      title: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Container(
          padding: const EdgeInsets.only(left: 8),
          decoration: const BoxDecoration(
            border: Border(left: BorderSide(width: 4, color: AppStyles.mainColor))
          ),          
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          context.t.mobileScreens.mdomAccountPaymentInfo.paymentDate,
                          style: TextStyle(
                            color: AppStyles.mainTextColor.withOpacity(0.7),
                            fontSize: 14,
                          ),                          
                        ),
                        const SizedBox(width: 4),   
                        Text(
                          DateFormat('dd.MM.yyyy HH:mm').format(paymentDate),
                          style: const TextStyle(
                            color: AppStyles.mainTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),                                              
                      ],
                    )               
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.t.mobileScreens.mdomAccountPaymentInfo.paymentCode.toUpperCase(),
                  style: TextStyle(
                    color: AppStyles.mainTextColor.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),                 
                Text(
                  item.id,
                  style: const TextStyle(
                      color: AppStyles.mainTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                  ),
                )
              ],
            ),  
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.t.mobileScreens.mdomAccountPaymentInfo.sum.toUpperCase(),
                  style: TextStyle(
                    color: AppStyles.mainTextColor.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ), 
                const SizedBox(height: 4),                
                Text(
                  item.amount.toStringAsFixed(2),
                  style: const TextStyle(
                      color: AppStyles.mainTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                  ),
                ),                             
              ],
            ),
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.t.mobileScreens.mdomAccountPaymentInfo.description.toUpperCase(),
                  style: TextStyle(
                    color: AppStyles.mainTextColor.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ), 
                const SizedBox(height: 4),               
                SizedBox(
                  width: MediaQuery.of(context).size.width/3,                  
                  child: Text(
                      item.infoPay ?? '',
                      maxLines: 2,
                      style: const TextStyle(
                          color: AppStyles.mainTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12
                      ),
                  ),
                ),                            
              ],
            ),           
          ]
        )
      ),
    );
  }
}


