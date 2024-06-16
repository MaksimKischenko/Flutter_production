import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

import 'widgets.dart';

class MdomPollScreenBody extends StatelessWidget {
  final int participantsCount;
  final Poll poll;
  final String? supplierTitle;
  
  const MdomPollScreenBody({
    super.key,
    required this.participantsCount,
    required this.poll,
    required this.supplierTitle
  });

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<VotePollBloc, VotePollState>(
        builder: (context, state) {
          Widget? body; 
          if (state is VotePollLoading) {
            body = const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: LoadingIndicator()),
            );
          } else if (state is VotePollLoaded) {
            body = PollScreenBodyContent(
              state: state,
              poll: poll,
              participantsCount: participantsCount,
              supplierTitle: supplierTitle,
            );
          }
          return body ?? const SizedBox.shrink();
        },
      );
}
