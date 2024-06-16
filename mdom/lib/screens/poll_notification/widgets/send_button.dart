import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendButton extends StatelessWidget {
  final bool active;
  final VoidCallback onTap;

  const SendButton({
    Key? key,
    this.active = true,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<PollsListBloc, PollsListState>(
    builder: (context, state) {
      if (state is PollsListLoading) {
        return MaterialButton(
          onPressed: null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
          highlightElevation: 0,
          minWidth: double.maxFinite,
          color: AppStyles.mainColor,
          disabledColor: AppStyles.mainTextColor.withOpacity(.3),
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: const SizedBox(
            width: 24,
            height: 24,
            child: LoadingIndicator(
              color: Colors.white,
            ),
          )
        );
      } else {
        return MaterialButton(
          onPressed: active ? onTap : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
          highlightElevation: 0,
          minWidth: double.maxFinite,
          color: AppStyles.mainColor,
          disabledColor: AppStyles.mainTextColor.withOpacity(.3),
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: const Text(
            'Отправить',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400
            ),
          )
        );
      }
    },
  );
}