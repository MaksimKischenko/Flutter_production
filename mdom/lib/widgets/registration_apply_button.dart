import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// only for RegistrationBloc!!!
class RegistrationApplyButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const RegistrationApplyButton({
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<RegistrationBloc, RegistrationState>(
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
          child: const SizedBox(
            width: 20,
            height: 20,
            child: LoadingIndicator()
          )
        );
      } else {
        return MaterialButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
          highlightElevation: 0,
          minWidth: double.maxFinite,
          color: AppStyles.mainColor,
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w300
            ),
          )
        );
      }
    },
  );
}