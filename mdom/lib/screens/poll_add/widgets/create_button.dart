import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateButton extends StatelessWidget {
  final bool active;
  final String text;
  final bool secondary;
  final VoidCallback onTap;

  const CreateButton({
    this.active = true,
    required this.text,
    this.secondary = false,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<AddPollBloc, AddPollState>(
    builder: (context, state) {
      if (state is AddPollInitial) {
        return MaterialButton(
          onPressed: active ? onTap : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
          highlightElevation: 0,
          minWidth: double.maxFinite,
          color: secondary ? const Color(0xffF1F3F8) : AppStyles.mainColor,
          disabledColor: AppStyles.mainTextColor.withOpacity(.3),
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Text(
            text,
            style: TextStyle(
              color: secondary ? AppStyles.mainColor : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400
            ),
          )
        );
      } else {
        return MaterialButton(
          onPressed: null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
          highlightElevation: 0,
          minWidth: double.maxFinite,
          color: secondary ? const Color(0xffF1F3F8) : AppStyles.mainColor,
          disabledColor: AppStyles.mainTextColor.withOpacity(.3),
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: SizedBox(
            width: 24,
            height: 24,
            child: LoadingIndicator(
              color: secondary ? AppStyles.mainColor : Colors.white,
            ),
          )
        );
      }
    },
  );
}