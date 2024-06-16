import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/routing/routes.gr.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

import 'widgets.dart';

class PollQuestionInfoBoby extends StatelessWidget {
  const PollQuestionInfoBoby({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<MdomPollQuestionInfoBloc, MdomPollQuestionInfoState>(
        builder: (context, state) {
          Widget? body;
          if (state is MdomPollQuestionInfoLoading) {
            body = const Padding(
              padding: EdgeInsets.only(top: 16),
              child: LoadingIndicator(),
            );
          } else if (state is MdomPollQuestionInfoError) {
            body = Error(context,
                message: state.error.toString(),
                onRepeatTap: () => context
                    .read<MdomPollQuestionInfoBloc>()
                    .add(MdomPollQuestionInfoInit()));
          } else if (state is MdomPollQuestionInfoErrorKomplat) {
            final isTokenError = state.errorCode == 403;

            body = isTokenError
                ? ErrorToken(
                    context,
                    message: state.errorMessage ??
                        context.t.mobileScreens.mdomPollStatisticsQuestion
                            .errorMessage,
                    onRepeatTap: () => context
                        .read<MdomPollQuestionInfoBloc>()
                        .add(MdomPollQuestionInfoInit()),
                  )
                : Error(
                    context,
                    message: state.errorMessage ??
                        context.t.mobileScreens.mdomPollStatisticsQuestion
                            .errorMessage,
                    onRepeatTap: () => context
                        .read<MdomPollQuestionInfoBloc>()
                        .add(MdomPollQuestionInfoInit()),
                  );
            if (isTokenError) {
              Future.delayed(
                  const Duration(seconds: 2),
                  () => AutoRouter.of(context).pushAndPopUntil(AuthRoute(),
                      predicate: (route) => false));
            }
          } else if (state is MdomPollQuestionInfoLoaded) {
            body = PollQuestionInfoBodyContent(state: state);
          }

          return body ?? const SizedBox.shrink();
        },
      );
}
