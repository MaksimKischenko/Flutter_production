import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/screens/mdom_poll/widgets/poll_bottom_sheet.dart';
import 'package:helppay_web_app/screens/mdom_poll/widgets/widgets.dart';
import 'package:helppay_web_app/utils/utils.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

class MdomPollScreenMainBody extends StatefulWidget {
  final int participantsCount;
  final Poll poll;
  final String? supplierTitle;

  const MdomPollScreenMainBody(
      {Key? key,
      required this.participantsCount,
      required this.poll,
      required this.supplierTitle})
      : super(key: key);

  @override
  State<MdomPollScreenMainBody> createState() => _MdomPollScreenMainBodyState();
}

class _MdomPollScreenMainBodyState extends State<MdomPollScreenMainBody> {
  @override
  Widget build(BuildContext context) =>
      BlocListener<VotePollBloc, VotePollState>(
        listener: (context, state) {
          if (state is VotePollSuccessVote) {
            AutoRouter.of(context)
                .navigatorKey
                .currentState
                ?.pop<Poll>(state.poll);
            Multiplatform.showMessage(
                context: context,
                title: state.edit
                    ? t.mobileScreens.mdomPoll.modal.successEdit
                    : t.mobileScreens.mdomPoll.modal.successVote,
                message: '',
                type: DialogType.success);
          }
        },
        child: Scaffold(
          appBar: AppBar(
              title: const CabinetMenu(selectedIndex: 0),
              toolbarHeight: 80,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white),
          body: MdomPollScreenBody(
            participantsCount: widget.participantsCount,
            poll: widget.poll,
            supplierTitle: widget.supplierTitle,
          ),
          persistentFooterAlignment: AlignmentDirectional.center,
          persistentFooterButtons: [
            BlocBuilder<VotePollBloc, VotePollState>(
              builder: (context, state) {
                Widget body = Container();
                if (state is VotePollLoading) {
                  body = const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: LoadingIndicator(),
                  );
                } else if (state is VotePollLoaded) {
                  body = PollBottomSheet(
                    state: state,
                    poll: widget.poll,
                    participantsCount: widget.participantsCount,
                    isVoteButtonActive: state.questions.length ==
                        state.questions
                            .where((e) => e.currentVote != null)
                            .length,
                  );
                }
                return body;
              },
            ),
          ],
        ),
      );
}
