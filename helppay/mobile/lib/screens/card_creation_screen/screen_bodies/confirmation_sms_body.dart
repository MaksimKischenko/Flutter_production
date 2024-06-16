import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/screens/card_creation_screen/widgets/widgets.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:sms_autofill/sms_autofill.dart';

class ConfirmationSMSBody extends StatefulWidget {
  final Function(int) navigationFunc;
  const ConfirmationSMSBody({required this.navigationFunc});

  @override
  State<ConfirmationSMSBody> createState() => _ConfirmationSMSBodyState();
}

class _ConfirmationSMSBodyState extends State<ConfirmationSMSBody> {

  Timer? timer;
  String? _currentCode = '';
  int currentSeconds = 0;
  int attemptNumber = 1;
  bool retryCode = false;


  @override
  void initState() {
    listenOtp();
    runTimer();    
    super.initState();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<CardsIssueBloc, CardsIssueState>(
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
        if(_currentCode!.isNotEmpty) {
          widget.navigationFunc(2);
        }
      }          
    },
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CardDesignHeader(
            headerText: context.t.mobileScreens.cardRegistration.params.title
          ),
          const SizedBox(height: 24),
          const ProgressIndicatorBar(
            currentPage: 1,
          ),
          const SizedBox(height: 24),
          Text(
            context.t.mobileScreens.cardRegistration.params.confirmCode,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppStyles.cardDesignTextColor),
          ),
          const SizedBox(
            height: 20,
          ),
          ConfirmationCodeField(
            currentCode: _currentCode,
            onCodeChanged: (code) {
              setState(() {
              _currentCode = code.toString();
              log('$_currentCode');
              });                
            },
          ),
          const SizedBox(height: 24),
          if (retryCode) GestureDetector(
            onTap: () {
              runTimer();
              context.read<CardsIssueBloc>().add(const CardIssueInitRun(retryResponse: true)); 
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.refresh,
                  color: AppStyles.mainColor
                ),
                Text(
                  context.t.mobileScreens.cardRegistration.params.retryCode,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppStyles.mainColor
                  ),
                )
              ],
            ),
          ) else Align(
            alignment: Alignment.topLeft,
            child: Text(
              '${context.t.mobileScreens.cardRegistration.params.retryCodeTimer}$currentSeconds',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff9B9CA8)
              ),
            ),
          ),
          const Spacer(),
          CardCreationActionButton(
            onTap: _currentCode?.length == 4 ? _onNextTap : null,
            title: context.t.mobileScreens.cardRegistration.nextButton,
          ),
        ],
      ),
    ));
  
  void _onNextTap() {
    context.read<CardsIssueBloc>().add(CardIssueOTPRun(otpCode: _currentCode ?? ''));
  }  


  Future<void> listenOtp() async {
    // final signature = await SmsAutoFill().getAppSignature;
    // log('SIGNATURE:$signature'); 
    log('OTP listen Called'); 
    await SmsAutoFill().listenForCode();
  }

  Future<void> runTimer() async {
    retryCode = false;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      setState(() {
        currentSeconds = timer.tick;
        if(currentSeconds >= 30) {
          currentSeconds = 0;
          retryCode = true;
          //attemptNumber++;
          timer.cancel();
        }
      });
    });
  }
}
