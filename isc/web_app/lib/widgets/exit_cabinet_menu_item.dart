import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isc_web_app/blocs/blocs.dart';
import 'package:isc_web_app/generated/translations.g.dart';
import 'package:isc_web_app/styles.dart';
import 'package:isc_web_app/utils/utils.dart';

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
            const Padding(
              padding: EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.exit_to_app,
                  color: AppStyles.cabinetMenuTextColor
                ),         
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