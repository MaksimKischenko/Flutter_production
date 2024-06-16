import 'package:bpc/data/data.dart';
import 'package:bpc/screens/registration_params/widgets/widgets.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegistrationParamsScreenBody extends StatelessWidget {
  final VoidCallback onProceedTap;
  final List<MdomResponseParam> paramsCopy;
  final GlobalKey<FormState> paramsFormKey;

  const RegistrationParamsScreenBody({
    super.key,
    required this.onProceedTap,
    required this.paramsCopy,
    required this.paramsFormKey,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: WebConstrainedBox(
            child: Column(
              children: [
                Expanded(
                  child: FullScreen(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16),
                        Image.asset(
                          'assets/images/main-logo.png',
                          width: 130,
                        ),
                        const SizedBox(height: 64),
                        const Text(
                          'Регистрация',
                          style: TextStyle(
                            color: AppStyles.mainTextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 26,
                          ),
                        ),
                        Form(
                          key: paramsFormKey,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                            itemCount: paramsCopy.length,
                            itemBuilder: (context, index) =>
                                RegistretionParamsFieldBuilder(
                              paramsCopy: paramsCopy,
                              index: index,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: RegistrationApplyButton(
                    text: 'Продолжить',
                    onPressed: onProceedTap,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
