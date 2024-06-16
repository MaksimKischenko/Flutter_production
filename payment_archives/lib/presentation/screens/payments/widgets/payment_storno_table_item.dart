import 'package:flutter/cupertino.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';


class PaymentStornoTableItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children:  [     
      DecoratedInfoContainer(
        color: CupertinoColors.systemRed.withOpacity(0.7), 
        text: 'Начато сторнирование платежа'
      ),
      DecoratedInfoContainer(
        color: CupertinoColors.systemYellow.withOpacity(0.7),
        text: 'Отменена регистрации платежа'
      ),      
    ],
  );
}
