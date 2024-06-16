import 'package:fl_qr_module/generated/translations.g.dart';
import 'package:fl_qr_module/navigation.dart';
import 'package:fl_qr_module/styles.dart';
import 'package:flutter/material.dart';

class QrHistoryNavigationButton extends StatelessWidget {
  const QrHistoryNavigationButton({super.key});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () async {
          await Navigation.toQrHistoryScreen();
        },
        child: DecoratedBox(
          decoration: const BoxDecoration(
            //borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(2, 2),
                color: Colors.grey,
                spreadRadius: .5,
                blurRadius: 2,
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 8,
            ),
            child: Text(
              context.t.mobileScreens.qrPayment.tranferHistory,
              style: const TextStyle(color: AppStyles.mainColorDark),
            ),
          ),
        ),
      );
}
