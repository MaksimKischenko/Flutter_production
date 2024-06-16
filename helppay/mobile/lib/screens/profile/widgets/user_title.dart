import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay/blocs/blocs.dart';
import 'package:helppay/styles.dart';

class UserTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          Widget body;
          if (state is ProfileInitial) {
            body = Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppStyles.mainColor.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: SvgPicture.asset(
                          'assets/icon/profile_user_placeholder.svg')
                      // child: FadeInImage.assetNetwork(
                      //   placeholder: "assets/icon/profile_user_placeholder.png",
                      //   image: "https://via.placeholder.com/80x80",
                      //   width: 56,
                      // ),
                      ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.username,
                        style: const TextStyle(
                          color: AppStyles.mainColorDark,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        state.email,
                        style: const TextStyle(
                          color: AppStyles.mainColorDark,
                          fontSize: 16,
                          // fontWeight: FontWeight.w500
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          } else {
            body = Container();
          }
          return body;
        },
      );
}
