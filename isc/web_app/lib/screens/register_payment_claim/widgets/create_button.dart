import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isc_web_app/blocs/blocs.dart';
import 'package:isc_web_app/styles.dart';
import 'package:isc_web_app/widgets/widgets.dart';


class CreateButton extends StatelessWidget {
  final String text;
  final Function() onTap;

  const CreateButton({
    required this.text,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<RegisterPaymentClaimBloc, RegisterPaymentClaimState>(
    builder: (context, state) {
      if (state is RegisterPaymentClaimLoading) {
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
          onPressed: onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
          highlightElevation: 0,
          minWidth: double.maxFinite,
          color: AppStyles.mainColor,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
          )
        );
      }
    },
  );
}