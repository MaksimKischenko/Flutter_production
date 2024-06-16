import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const ActionButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<PollsListBloc, PollsListState>(
    builder: (context, state) {
      if (state is PollsListLoading) {
        return TextButton(
          onPressed: onTap,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xffF1F3F8)),
            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 8, vertical: 16)),
          ),
          child: const SizedBox(
            width: 24,
            height: 24,
            child: LoadingIndicator(
              color: Colors.white,
            ),
          )
        );
      } else {
        return TextButton(
          onPressed: onTap,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xffF1F3F8)),
            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 8, vertical: 16)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: AppStyles.mainColor,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppStyles.mainColor,
                ),
              ),
            ],
          ),
        );
      }
    },
  );
}