import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/screens/card_creation_screen/widgets/widgets.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';


class PhoneNumberInputBody extends StatefulWidget {
  final Function(int) navigationFunc;
  const PhoneNumberInputBody({required this.navigationFunc});
  @override
  State<PhoneNumberInputBody> createState() => _PhoneNumberInputBodyState();
}

class _PhoneNumberInputBodyState extends State<PhoneNumberInputBody> {
  final GlobalKey<FormState> _phoneNumberFormKey = GlobalKey<FormState>();
  bool switchValue1 = false;
  bool switchValue2 = false;
  bool switchValue3 = false;
  String? phoneNumber;


  @override
  Widget build(BuildContext context) => BlocConsumer<CardsIssueBloc, CardsIssueState>(
      listener: (context, state) {
        if(state is CardsIssueNetworkError) {
          kReleaseMode?
          Multiplatform.showMessage(
            context: context, 
            title: context.t.mobileScreens.cardRegistration.params.errorsInfoMessaes.errorTitle,
            message: context.t.mobileScreens.cardRegistration.params.errorsInfoMessaes.errorMessage,
            type: DialogType.error
          ):            
          RequestUtil.catchNetworkError(
            context: context, 
            obj: state.error
          );
        } else if(state is CardsIssueErrorKomplat) {
          kReleaseMode?
          Multiplatform.showMessage(
            context: context, 
            title: context.t.mobileScreens.cardRegistration.params.errorsInfoMessaes.errorTitle,
            message: context.t.mobileScreens.cardRegistration.params.errorsInfoMessaes.errorMessage,
            type: DialogType.error
          ):    
          RequestUtil.catchKomplatError(
            context: context, 
            errorCode: state.errorCode, 
            errorText: state.errorMessage
          );
        } else if(state is CardsIssueSuccessfulResponse) {
          widget.navigationFunc(1);
        }
      },
      builder: (context, state) {
        Widget body = Container();
        if(state is CardsIssueLoading) {
          body = const LoadingIndicator();
        } 
        else {
          body = Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardDesignHeader(
                  headerText: context.t.mobileScreens.cardRegistration.params.title,
                ),
                const SizedBox(height: 24),
                const ProgressIndicatorBar(
                  currentPage: 0,
                ),    
                const SizedBox(height: 24),                        
                Text(
                  context.t.mobileScreens.cardRegistration.params.phone,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppStyles.cardDesignTextColor
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _phoneNumberFormKey,
                  child: PhoneNumberField(
                    onChanged: (value) {},
                    onSaved: (value) {
                      phoneNumber = '375$value';
                    },
                  ),
                ),
                const SizedBox(height: 30),
                AgreementsContainer(
                  value1: switchValue1,
                  value2: switchValue2,
                  value3: switchValue3,
                  onChangeValue1: (value) {
                    setState(() {
                      switchValue1 = value ?? false;
                    });
                  },
                  onChangeValue2: (value) {
                    setState(() {
                      switchValue2 = value ?? false;
                    });
                  },
                  onChangeValue3: (value) {
                    setState(() {
                      switchValue3 = value ?? false;
                    });
                  },
                ),
                const Spacer(),
                CardCreationActionButton(
                  onTap: switchValue1 &&
                         switchValue2 &&
                         switchValue3
                      ? _onNextTap
                      : null,
                  title: context.t.mobileScreens.cardRegistration.nextButton,
                ),
              ],
            ),
          );
        }
        return body;
      },
    );

  Future<void> _onNextTap() async {
    // final signature = await SmsAutoFill().getAppSignature;
    // log('SIGNATURE:$signature'); 
    if (_phoneNumberFormKey.currentState?.validate() ?? false) {
      _phoneNumberFormKey.currentState?.save();
      context.read<CardsIssueBloc>().add(CardIssueInitRun(phoneNumber: phoneNumber ?? ''));
    }
  }  
}
