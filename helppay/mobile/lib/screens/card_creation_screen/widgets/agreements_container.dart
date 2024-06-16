// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class AgreementsContainer extends StatelessWidget {
  final bool value1;
  final bool value2;
  final bool value3;    
  final Function(bool?) onChangeValue1;
  final Function(bool?) onChangeValue2;
  final Function(bool?) onChangeValue3;  

  const AgreementsContainer({
    Key? key,
    required this.value1,
    required this.value2,
    required this.value3,
    required this.onChangeValue1,
    required this.onChangeValue2,
    required this.onChangeValue3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        children: [
          SizedBox(
            width: 20,
            child: Checkbox(
              value: value1, 
              onChanged: onChangeValue1,
              side: const BorderSide(
                color:  Color(0xffC3C6CD),
              ), 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3)
              ), 
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                text: context.t.mobileScreens.cardRegistration.params.agrement1.agrementsTextSpan1,
                style: AppStyles.agreementsTextStyle,
                children: [
                  TextSpan(
                    text: context.t.mobileScreens.cardRegistration.params.agrement1.agrementsTextSpan2,
                    style: AppStyles.agreementsLinkTextStyle,
                    recognizer:  TapGestureRecognizer()..onTap = () async{
                      
                    }
                  ),
                  TextSpan(
                    text: context.t.mobileScreens.cardRegistration.params.agrement1.agrementsTextSpan3,
                    style: AppStyles.agreementsTextStyle
                  ),
                  TextSpan(
                    text: context.t.mobileScreens.cardRegistration.params.agrement1.agrementsTextSpan4,
                    style: AppStyles.agreementsLinkTextStyle,
                    recognizer:  TapGestureRecognizer()..onTap = () async{            
                    }
                  ),                                                                                                                 
                ]
              )
            ),
          )            
        ],
      ),
      Row(
        children: [
          SizedBox(
            width: 20,
            child: Checkbox(
              value: value2, 
              onChanged: onChangeValue2,
              side: const BorderSide(
                color:  Color(0xffC3C6CD),
              ), 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3)
              ), 
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                text: context.t.mobileScreens.cardRegistration.params.agrement2.agrementsTextSpan1,
                style: AppStyles.agreementsTextStyle,
                children: [
                  TextSpan(
                    text: context.t.mobileScreens.cardRegistration.params.agrement2.agrementsTextSpan2,
                    style: AppStyles.agreementsLinkTextStyle,
                    recognizer: TapGestureRecognizer()..onTap = () async{
                      
                    }
                  ),                                                                                                                 
                ]
              )
            ),
          )            
        ],
      ),
      Row(
        children: [
          SizedBox(
            width: 20,
            child: Checkbox(
              value: value3, 
              onChanged: onChangeValue3,
              side: const BorderSide(
                color:  Color(0xffC3C6CD),
              ), 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3)
              ), 
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                text: context.t.mobileScreens.cardRegistration.params.agrement3.agrementsTextSpan1,
                style: AppStyles.agreementsTextStyle,
                children: [
                  TextSpan(
                    text: context.t.mobileScreens.cardRegistration.params.agrement3.agrementsTextSpan2,
                    style: AppStyles.agreementsLinkTextStyle,
                    recognizer: TapGestureRecognizer()..onTap = () async{
                    }
                  ),                                                                                                                 
                ]
              )
            ),
          )            
        ],
      )                    
    ],
  );
}
