import 'package:flutter/material.dart';
import 'package:helppay/screens/products/widgets/widgets.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class AddCardElement extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xffEAEEF6),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/images/bnb_logo.png'),
                height: 32,
                width: 32,
              ),
              const SizedBox(width: 8),
              Text(
                context.t.mobileScreens.cardRegistration.params.cardTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          MaterialButton(
            onPressed: () =>  CardOrderAgreementDialogWidgetActivator.showMessage(context: context), //Navigation.toWebViewScreen(), 
            color: AppStyles.mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),          
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add, color: Colors.white),
                  Text(
                    context.t.mobileScreens.cardRegistration.addButton,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white
                    ),
                  ),               
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}