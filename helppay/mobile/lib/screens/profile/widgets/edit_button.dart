import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay/blocs/blocs.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay_core/helppay_core.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'profile_edit_button');

class EditButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        if (state is ProfileInitial) {
          _log('profile lookups data - ${state.lookups}');
          _log(
              'profile lookups data value- ${state.lookups?.items?[0].evalue}');

          return IconButton(
            icon: SvgPicture.asset('assets/icon/profile_edit.svg'),
            tooltip: context.t.mobileScreens.profile.editButton,
            onPressed: () => Navigation.toProfileEdit(
              userParams: state.userParams,
              lookups: state.lookups,
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      });
}
