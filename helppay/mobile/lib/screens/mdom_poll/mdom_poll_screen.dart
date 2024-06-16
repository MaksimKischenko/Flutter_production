import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets/widgets.dart';

class MdomPollScreen extends StatefulWidget {
  static const pageRoute = '/poll';

  final int participantsCount;
  final Poll poll;

  const MdomPollScreen({
    Key? key,
    required this.participantsCount,
    required this.poll,
  }) : super(key: key);

  @override
  State<MdomPollScreen> createState() => _MdomPollScreenState();
}

class _MdomPollScreenState extends State<MdomPollScreen> {
  late ScrollController _scrollController;

  double get titleSize => 77;

  bool _isTitleVisible = false;

  bool get _showTitle =>
      _scrollController.hasClients && _scrollController.offset - titleSize > 0;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_isTitleVisible != _showTitle) {
        setState(() {
          _isTitleVisible = !_isTitleVisible;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<VotePollBloc, VotePollState>(
        listener: (context, state) {
          if (state is VotePollSuccessVote) {
            Navigator.of(context).pop<Poll>(state.poll);
            Multiplatform.showMessage(
                context: context,
                // title: '',
                title: state.edit
                    ? t.mobileScreens.mdomPoll.modal.successEdit
                    : t.mobileScreens.mdomPoll.modal.successVote,
                message: '',
                type: DialogType.success);
          }
        },
        child: Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: _showTitle
                ? Text(
                    widget.poll.topic,
                    style: const TextStyle(color: AppStyles.mainColorDark),
                  )
                : null,
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          body: MdomPollScreenBody(
            participantsCount: widget.participantsCount,
            poll: widget.poll,
            scrollController: _scrollController,
          ),
        ),
      );
}
