import 'package:flutter/material.dart';

import 'package:helppay_core/data/data.dart';
import 'package:helppay_core/generated/translations.g.dart';
import 'package:helppay_web_app/navigation.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:intl/intl.dart';

class RequirementsItem extends StatelessWidget {
  final List<MdomService> services;
  final List<PaymentBilling> payments;


  const RequirementsItem({
    Key? key,
    required this.services, 
    required this.payments,
  }) : super(key: key);

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.maxFinite,
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final _claimId = services[index].claimId;
            final _total = services[index].total;
            
            final _dateBegin = DateFormat(services[index].dateBegin!.length > 10 ? 'dd/MM/yyyy HH:mm:ss' : 'dd/MM/yyyy').parse(services[index].dateBegin ?? '01.01.2022');
            final _dateEnd = DateFormat(services[index].dateEnd!.length > 10? 'dd/MM/yyyy HH:mm:ss' : 'dd/MM/yyyy').parse(services[index].dateEnd ?? '01.01.2022');
            final _payAmount = services[index].payAmount ?? 0.0;

            return GestureDetector(
              onTap: () {
                if (_payAmount  > 0){
                  final sortedPyments = payments.where((element) => element.claimId == services[index].claimId).toList();
                   Navigation.toMdomAccountInfoPaymentScreen(context: context, paymentsList: sortedPyments);
                }
              },
              behavior: HitTestBehavior.translucent,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                title: Container(
                  padding: const EdgeInsets.only(left: 8),
                  decoration: const BoxDecoration(
                    border: Border(left: BorderSide(width: 4, color: AppStyles.mainColor))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${context.t.mobileScreens.payment.requirmentNumber }:',
                             style: const TextStyle(
                                color: AppStyles.mainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                             ),
                          ),
                          const SizedBox(width:4),
                          Text(
                            '$_claimId',
                            style: const TextStyle(
                              color: AppStyles.mainColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      if (_payAmount > 0)
                        Row(
                          children: [
                            Text(
                              context.t.mobileScreens.payment.details,
                              style: const TextStyle(
                                color: AppStyles.mainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12                                 
                              ),
                            ),   
                            const Icon(Icons.navigate_next,
                              color: AppStyles.mainColor
                            ),
                          ],
                        )
                      else
                        const SizedBox.shrink()
                    ],
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              context.t.mobileScreens.mdomAccountInfo.requirementsInfo.dateStart,
                              textAlign: TextAlign.center,                              
                              style: TextStyle(
                                color: AppStyles.mainTextColor.withOpacity(0.7),
                                fontSize: 10
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              context.t.mobileScreens.mdomAccountInfo.requirementsInfo.dateEnd,
                              textAlign: TextAlign.center,   
                              maxLines: 2,                           
                              style: TextStyle(
                                color: AppStyles.mainTextColor.withOpacity(0.7),
                                fontSize: 10
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              context.t.mobileScreens.mdomAccountInfo.requirementsInfo.total,                   
                              textAlign: TextAlign.center,                              
                              style: TextStyle(
                                color: AppStyles.mainTextColor.withOpacity(0.7),
                                fontSize: 10
                              ),
                            ),
                          ),  
                          Expanded(
                            child: Text(
                              context.t.mobileScreens.mdomAccountInfo.requirementsInfo.accrued,
                              textAlign: TextAlign.center,                              
                              style: TextStyle(
                                color: AppStyles.mainTextColor.withOpacity(0.7),
                                fontSize: 10
                              ),
                            ),
                          ),                                                         
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(                               
                                    DateFormat('dd.MM.yyyy').format(_dateBegin),
                                    style: const TextStyle(
                                      color: AppStyles.mainTextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12
                                    ),                                    
                                  ),
                                  Text(                               
                                    DateFormat('HH:mm').format(_dateBegin),
                                    style: const TextStyle(
                                      color: AppStyles.mainTextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10
                                    ),
                                  ),                                  
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(                               
                                    DateFormat('dd.MM.yyyy').format(_dateEnd),
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                      color: AppStyles.mainTextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12
                                    ),                                    
                                  ),
                                  Text(                               
                                    DateFormat('HH:mm').format(_dateEnd),
                                    style: const TextStyle(
                                      color: AppStyles.mainTextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10
                                    ),
                                  ),                                  
                                ],
                              ),
                            ),  
                            Expanded(
                              child: Text(
                                '$_total',
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  color: AppStyles.mainTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12
                                ),
                              ),
                            ), 
                            Expanded(
                              child: Text(
                                _payAmount.toStringAsFixed(2),
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  color: AppStyles.mainTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12
                                ),
                              ),
                            ),                                                                                                          
                          ],
                        ),
                      )                                            
                    ],
                  )
                ),
              ),
            );
          }),
    );
  }
}

