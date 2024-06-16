import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/blocs/blocs.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/widgets/widgets.dart';

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
            // return Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 8),
            //   child: LoadingIndicator(),
            // );
            return MaterialButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
                highlightElevation: 0,
                minWidth: double.maxFinite,
                color: Colors.transparent,
                padding: const EdgeInsets.only(top: 15, bottom: 14),
                child: const LoadingIndicator());
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
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Text(
                text,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w300),
              ),
            );
          }
        },
      );
}
