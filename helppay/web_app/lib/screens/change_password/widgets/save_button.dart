import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

class SaveButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const SaveButton({
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
    builder: (context, state) {
      Widget body = Container();

      if (state is ChangePasswordLoading ||
          state is ChangePasswordActionLoading) {
        body = const LoadingIndicator();
      } else {
        body = TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(
              color: AppStyles.mainColor,
              fontSize: 16,
              fontWeight: FontWeight.w300
            ),
          ),
        );
      }

      return body;
    },
  );
}