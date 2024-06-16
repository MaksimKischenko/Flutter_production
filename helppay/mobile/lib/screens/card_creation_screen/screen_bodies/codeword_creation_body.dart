import 'package:flutter/material.dart';
import 'package:helppay/screens/card_creation_screen/widgets/widgets.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';


class CodeWordCreationBody extends StatefulWidget {
  final Function(int) navigationFunc;
  const CodeWordCreationBody({required this.navigationFunc});
  @override
  State<CodeWordCreationBody> createState() => _CodeWordCreationBodyState();
}

class _CodeWordCreationBodyState extends State<CodeWordCreationBody> {

  final GlobalKey<FormState> _codeWordFormKey = GlobalKey<FormState>();

  bool _codeWordCorrect = false;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Form(
      key: _codeWordFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CardDesignHeader(
            headerText: context.t.mobileScreens.cardRegistration.params.title,
          ),
          const SizedBox(height: 58),
          Text(
            context.t.mobileScreens.cardRegistration.params.codeWordTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppStyles.cardDesignTextColor
              
            ),
          ),
          const SizedBox(height: 8),       
          Text(
            context.t.mobileScreens.cardRegistration.params.codeWordDesctiption,
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
          CodeWordField(
            onFieldSubmitted: (value) {
              setState(() {
                _codeWordCorrect = _codeWordFormKey.currentState!.validate();
              });              
            },            
          ),
          const SizedBox(height: 24),
          const Spacer(),
          CardCreationActionButton(
            onTap: _codeWordCorrect
                ? () async {
                    //await Navigation.toWebViewScreen();
                    // widget.navigationFunc(4);
                  }
                : null,
            title: context.t.mobileScreens.cardRegistration.nextButton,
          ),
        ],
      ),
    ),
  );
}
