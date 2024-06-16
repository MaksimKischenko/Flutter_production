import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

class NextButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const NextButton({
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<PaymentBloc, PaymentState>(
    builder: (context, state) {
      if (state is PaymentLoading) {
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
          child: const LoadingIndicator()
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