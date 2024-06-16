import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/blocs/blocs.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/utils/utils.dart';

class ExitCabinetMenuItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) => TextButton(
      onPressed:  () {
         Multiplatform.showDecisionMessage(
          context: context,
          dialogTitle: t.modal.logOut.title,
          message: '', 
          action: () {
            context.read<AuthBloc>().add(AuthLogOut());
          },
          buttonTitle: t.modal.logOut.confirmButton,
          cancelButtonTitle: t.modal.logOut.cancelButton
      );
      },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(const Color(0xffEDF6FF))
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icon/profile_log_out.svg',
              colorFilter: const ColorFilter.mode(AppStyles.cabinetMenuTextColor, BlendMode.srcIn),
              height: 16,
            ),           
            Text(
              context.t.mobileScreens.profile.logOutItem.title,
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
}