import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_web_app/blocs/blocs.dart';
import 'package:helppay_web_app/styles.dart';

class ProfileCabinetMenuItem extends StatelessWidget {

  final Function() onTap;

  const ProfileCabinetMenuItem({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
        Widget body;
        if (state is ProfileInitial) {
          body = TextButton(
            onPressed: onTap,
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(const Color(0xffEDF6FF))
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  const Icon(
                    Icons.person_outline,
                    color: AppStyles.cabinetMenuTextColor,
                  ),
                  Text(
                    state.username,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: AppStyles.cabinetMenuTextColor
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          body = Container();
        }
        return body;
      },
    );
}



