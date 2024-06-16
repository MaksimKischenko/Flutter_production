import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay/screens/card_creation_screen/widgets/widgets.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

class IndificationNumberBody extends StatefulWidget {
  final Function(int) navigationFunc;
  const IndificationNumberBody({required this.navigationFunc});

  @override
  State<IndificationNumberBody> createState() => _IndificationNumberBodyState();
}

class _IndificationNumberBodyState extends State<IndificationNumberBody> {
  final GlobalKey<FormState> _personalNumberFormKey = GlobalKey<FormState>();
  String _personalNumber = '';

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
          if(state.needMSI ?? false) {
            Navigation.toWebViewScreen();
          } else {
            widget.navigationFunc(3);
          }
      } else if (state is CardsIssue123ConfirmResponse) {
        widget.navigationFunc(3);
      }          
    },
    builder: (context, state) {
      Widget body = Container();
      if(state is CardsIssueLoading) {
        body = const LoadingIndicator();
      } else {
        body = Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _personalNumberFormKey,
            child: Column(
              children: [
                CardDesignHeader(
                  headerText:
                      context.t.mobileScreens.cardRegistration.params.title,
                ),
                const SizedBox(height: 24),
                const ProgressIndicatorBar(
                  currentPage: 2,
                ),
                const SizedBox(height: 24),
                Text(
                  context.t.mobileScreens.cardRegistration.params.idNumber,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppStyles.cardDesignTextColor),
                ),
                const SizedBox(height: 8),
                Text(
                  context.t.mobileScreens.cardRegistration.params.idNumberDesctiption,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppStyles.cardDesignTextColor
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                IndificationNumberField(
                  onSaved: (value) {
                    _personalNumber = value;
                  },
                ),
                const SizedBox(height: 24),
                const Spacer(),
                CardCreationActionButton(
                  onTap: _onNextTap,
                  title: context.t.mobileScreens.cardRegistration.nextButton,
                ),
              ],
            ),
          ),
        );
      }         
      return body;
    },
  );

  void _onNextTap() {
    if (_personalNumberFormKey.currentState?.validate() ?? false) {
      _personalNumberFormKey.currentState?.save();
       context.read<CardsIssueBloc>().add(CardIssueIdentifyUserRun(personalNumber: _personalNumber));
    }
  }    
}
