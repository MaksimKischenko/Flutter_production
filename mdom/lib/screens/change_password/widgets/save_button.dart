import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SaveButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
        builder: (context, state) {
          Widget body = Container();

          if (state is ChangePasswordLoading ||
              state is ChangePasswordActionLoading) {
            body = const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: LoadingIndicator(),
              ),
            );
          } else {
            body = TextButton(
              onPressed: onPressed,
              child: Text(
                text,
                style: const TextStyle(
                    color: AppStyles.mainColor,
                    // fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            );
          }

          return body;
        },
      );
}
