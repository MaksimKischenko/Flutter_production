import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets.dart';

class MdomPollScreenBody extends StatelessWidget {
  final int participantsCount;
  final Poll poll;
  final ScrollController scrollController;
  const MdomPollScreenBody({
    super.key,
    required this.participantsCount,
    required this.poll,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<VotePollBloc, VotePollState>(
        builder: (context, state) {
          Widget? body;

          if (state is VotePollLoading) {
            body = const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: LoadingIndicator(),
            );
          } else if (state is VotePollLoaded) {
            body = PollScreenBodyContent(
              state: state,
              poll: poll,
              participantsCount: participantsCount,
              scrollController: scrollController,
            );
          }
          return body ?? const SizedBox.shrink();
        },
      );
}
