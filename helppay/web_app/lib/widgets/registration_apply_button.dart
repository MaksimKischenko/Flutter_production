import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_web_app/blocs/blocs.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

/// only for RegistrationBloc!!!
class RegistrationApplyButton extends StatelessWidget {
  final String? selectedContactOption;
  final bool? checkboxValue1;
  final bool? checkboxValue2;
  final String text;
  final Function() onPressed;

  const RegistrationApplyButton({
    required this.text,
    required this.onPressed,
    this.selectedContactOption,
    this.checkboxValue1,
    this.checkboxValue2,
  });

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
          if (state is RegistrationLoading) {
            return MaterialButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
              highlightElevation: 0,
              minWidth: double.maxFinite,
              color: Colors.transparent,
              child: const LoadingIndicator(),
            );
          } else {
            return MaterialButton(
              onPressed: () {
                if (selectedContactOption == 'PHONE') {
                  (checkboxValue1! && checkboxValue2!) ? onPressed() : null;
                } else {
                  onPressed();
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
              highlightElevation: 0,
              minWidth: double.maxFinite,
              color: selectedContactOption == 'PHONE'
                  ? (checkboxValue1! && checkboxValue2!)
                      ? AppStyles.mainColor
                      : Colors.grey
                  : AppStyles.mainColor,
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          }
        },
      );
}
