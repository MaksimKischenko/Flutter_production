import 'package:flutter/material.dart';
import 'package:helppay/injection_component.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay/screens/card_creation_screen/widgets/widgets.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';


class SuccessCardCreationBody extends StatefulWidget {
  final DataManager dataManager;
  final Function(int) navigationFunc;

  SuccessCardCreationBody({
    required this.navigationFunc
  }):dataManager = InjectionComponent.getDependency<DataManager>();


  @override
  State<SuccessCardCreationBody> createState() =>
      _SuccessCardCreationBodyState();
}

class _SuccessCardCreationBodyState extends State<SuccessCardCreationBody> {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CardDesignHeader(
          finalPage: true,
          headerText: t.mobileScreens.cardRegistration.params.bnbTitle
        ),
        const SizedBox(height: 24),
        const ProgressIndicatorBar(
          currentPage: 4,
        ),   
        const SizedBox(height: 24),             
        Text(
          context.t.mobileScreens.cardRegistration.params.successRegistrationCard,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppStyles.cardDesignTextColor
            
          ),
        ),        
        const SizedBox(height: 8),
        Text(
          context.t.mobileScreens.cardRegistration.params.successRegistrationCardDesctiption,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppStyles.cardDesignTextColor              
          ),            
        ),
        const SizedBox(height: 24),
        Image.network(
          '${widget.dataManager.cardPictureUrl}',
          loadingBuilder: (context, child, loadingProgress) {
            if(loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                color: AppStyles.mainColor,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
        const Spacer(),
        CardCreationActionButton(
          onTap: () async {
            await Navigation.toMain();
          },
          title: context.t.mobileScreens.cardRegistration.successButton,
        ),
      ],
    ),
  );
}
