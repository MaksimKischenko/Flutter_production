import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/blocs/profile/profile_bloc.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

class SaveButton extends StatelessWidget {
  final Function() onTap;

  const SaveButton({
    required this.onTap
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<ProfileBloc, ProfileState>(
    builder: (context, state) {
      Widget body;
      if (state is ProfileInitial) {
        body = TextButton(
          onPressed: onTap,
          child: Text(
            context.t.mobileScreens.profileEdit.saveButton,
            style: const TextStyle(
              fontSize: 18,
              color: AppStyles.mainColorDark,
              fontWeight: FontWeight.w400
            ),
          ),
        );
      } else {
        body = const LoadingIndicator();
      }
      return body;
    },
  );
}