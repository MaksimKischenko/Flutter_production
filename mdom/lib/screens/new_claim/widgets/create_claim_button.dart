import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateClaimButton extends StatelessWidget {
  final VoidCallback onTap;

  const CreateClaimButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<NewClaimBloc, NewClaimState>(
    builder: (context, state) {
      if (state is NewClaimLoading) {
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
          onPressed: onTap,
          child: const Text(
            'Создать',
            style: TextStyle(
              color: AppStyles.mainColor,
              // fontSize: 16,
              fontWeight: FontWeight.w400
            ),
          ),
        );
      }
    },
  );
}