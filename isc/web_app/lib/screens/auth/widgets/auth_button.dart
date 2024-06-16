import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isc_web_app/blocs/blocs.dart';
import 'package:isc_web_app/styles.dart';
import 'package:isc_web_app/widgets/widgets.dart';


/// only for AuthBloc!!!
class AuthButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const AuthButton({
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<AuthBloc, AuthState>(
    builder: (context, state) {
      if (state is AuthLoading) {
        return MaterialButton(
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
          highlightElevation: 0,
          minWidth: double.maxFinite,
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 18),
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
          padding: const EdgeInsets.symmetric(vertical: 18),
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