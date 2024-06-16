import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/styles.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';

class NextTextButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color color;

  const NextTextButton({
    required this.text,
    required this.onPressed,
    this.color = AppStyles.mainColor
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<PaymentBloc, PaymentState>(
    builder: (context, state) {
      if (state is PaymentLoading) {
        // return Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 8),
        //   child: LoadingIndicator(),
        // );
        return TextButton(
          onPressed: () {},
          style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 20, horizontal: 16))
          ),
          child: const SizedBox(
            width: 20,
            height: 20,
            child: LoadingIndicator()
          )
        );
      } else {
        return TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 14, horizontal: 24)),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 16,
              // fontWeight: FontWeight.w400
            ),
          )
        );
      }
    },
  );
}