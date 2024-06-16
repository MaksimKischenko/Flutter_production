import 'package:bpc_nkfo/blocs/blocs.dart';
import 'package:bpc_nkfo/styles.dart';
import 'package:bpc_nkfo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateClaimButton extends StatelessWidget {
  final ClaimsBloc bloc;
  final Function() onPressed;

  const CreateClaimButton({
    required this.bloc,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<ClaimsBloc, ClaimsState>(
    bloc: bloc,
    builder: (context, state) {
      if (state is ClaimsLoading) {
        return TextButton(
          onPressed: () {},
          child: const SizedBox(
            width: 20,
            height: 20,
            child: LoadingIndicator(),
          ),
        );
      } else {
        return TextButton(
          onPressed: onPressed,
          child: const Text(
            'Создать',
            style: TextStyle(
              color: AppStyles.mainColor,
              // fontSize: 16,
              fontWeight: FontWeight.w400
            ),
          )
        );
      }
    },
  );
}