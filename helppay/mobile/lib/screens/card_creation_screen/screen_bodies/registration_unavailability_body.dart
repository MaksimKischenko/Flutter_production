import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay/screens/card_creation_screen/widgets/widgets.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';


class RegistrationUnavailabilityBody extends StatefulWidget {
  final Function(int) navigationFunc;
  const RegistrationUnavailabilityBody({required this.navigationFunc});
  @override
  State<RegistrationUnavailabilityBody> createState() =>
      _RegistrationUnavailabilityBodyState();
}

class _RegistrationUnavailabilityBodyState
    extends State<RegistrationUnavailabilityBody> {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CardDesignHeader(
          headerText: context.t.mobileScreens.cardRegistration.params.title,
        ),
        const SizedBox(height: 48),
        SvgPicture.asset('assets/icon/dialog_info.svg'),
        const SizedBox(height: 24),
        Text(
          context.t.mobileScreens.cardRegistration.params.errorsInfoMessaes.errorTitleMSI,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppStyles.cardDesignTextColor
          ),
        ),
        const SizedBox(height: 12),
        Text(
          context.t.mobileScreens.cardRegistration.params.errorsInfoMessaes.errorTitleDesctiptionMSI,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppStyles.cardDesignTextColor              
          ),
        ),        
        const Spacer(),
        CardCreationActionButton(
          onTap: () async {
            await Navigation.toMain();
          },
          title: context.t.mobileScreens.cardRegistration.closeButton,
        ),
      ],
    ),
  );
}
