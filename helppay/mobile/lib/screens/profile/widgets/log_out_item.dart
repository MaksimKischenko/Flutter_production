import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay/blocs/blocs.dart';
import 'package:helppay/config.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay_core/helppay_core.dart';

class LogOutItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) => InkWell(
      onTap: () {
        Multiplatform.showDecisionMessage(
          context: context,
          dialogTitle: t.modal.logOut.title,
          message: '',//t.modal.logOut.message,
          action: () {
            context.read<AuthBloc>().add(AuthLogOut());
            context.read<MenuBloc>().add(MenuTabUpdate(tab: AppConfig.defaultMenuTab, isBnbCardAdd: false));                    
          },
          buttonTitle: t.modal.logOut.confirmButton,
          cancelButtonTitle: t.modal.logOut.cancelButton
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SvgPicture.asset(
              'assets/icon/profile_log_out.svg'
            ),
            const SizedBox(width: 12),
            Text(
              context.t.mobileScreens.profile.logOutItem.title,
              style: const TextStyle(
                color: Color(0xff383A51),
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
}