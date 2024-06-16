import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/data/routing/routes.gr.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/utils/multiplatform.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExitCabinetMenuItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: () {
          Multiplatform.showDecisionMessage(
              context: context,
              dialogTitle: 'Уверены, что хотите выйти?',
              message: '',
              action: () {
                // context.read<AuthBloc>().add(AuthLogOut());
                context.read<AuthMdomBloc>().add(AuthMdomLogOut());
                AutoRouter.of(context)
                    .push(!kIsWeb ? const SplashRoute() : const AuthRoute());
              },
              buttonTitle: 'Выйти',
              cancelButtonTitle: 'Остаться');
        },
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(const Color(0xffEDF6FF))),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icon/profile_log_out.svg',
                color: AppStyles.mainTextColor,
                height: 16,
              ),
              const Text(
                'Выход',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: AppStyles.mainTextColor,
                ),
              ),
            ],
          ),
        ),
      );
}
