
import 'package:flutter/material.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class CardAgreementDialogChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(12, 24, 12, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 18),
        RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              text: context.t.mobileScreens.cardRegistration.params.agrement0.agrementsTextSpan1,
              style: AppStyles.agreementsTextStyle,
              children: [
                TextSpan(
                  text: context.t.mobileScreens.cardRegistration.params.agrement0.agrementsTextSpan2,
                  style: AppStyles.agreementsTextStyleBold,
                ),
                TextSpan(
                  text: context.t.mobileScreens.cardRegistration.params.agrement0.agrementsTextSpan3,
                  style: AppStyles.agreementsTextStyle
                ),                                                                                                                
              ]
            )
        ),  
        const Spacer(), 
        Container(
          color: 
          Colors.grey.withOpacity(0.2), 
          width: MediaQuery.of(context).size.width, 
          height: 1
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: ()=> Navigator.of(context).pop(),
              child: Text(
                context.t.mobileScreens.cardRegistration.cancelButton,
                style: const TextStyle(
                  color: AppStyles.mainColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
            Container(
              color: Colors.grey.withOpacity(0.2), 
              width: 1, 
              height: MediaQuery.of(context).size.height/18.5
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await Navigation.toCardCreationScreenScreen();
              },
              child: Text(
                context.t.mobileScreens.cardRegistration.continueButton,
                style: const TextStyle(
                  color: AppStyles.mainColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}


