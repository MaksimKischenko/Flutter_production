import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/screens/poll/main_widgets/poll_screen_body.dart';
import 'package:bpc/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/widgets.dart';

@RoutePage()
class PollScreen extends StatefulWidget {
  static const pageRoute = '/poll';

  final int participantsCount;
  final int confirmedCount;
  final Poll poll;

  const PollScreen({
    Key? key,
    required this.participantsCount,
    required this.confirmedCount,
    required this.poll,
  }) : super(key: key);

  @override
  State<PollScreen> createState() => _PollScreenState();
}

class _PollScreenState extends State<PollScreen> {
  late ScrollController _scrollController;

  double get titleSize => 77;

  bool _isTitleVisible = false;

  bool get _showTitle =>
      _scrollController.hasClients && _scrollController.offset - titleSize > 0;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(
      () {
        if (_isTitleVisible != _showTitle) {
          setState(() {
            _isTitleVisible = !_isTitleVisible;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<PollsListBloc, PollsListState>(
        listener: (context, state) {
          if (state is PollsListCancelPollSuccess) {
            if (state.id == widget.poll.id) {
              _onCancelSuccess();
            }
          } else if (state is PollsListDeletePollSuccess) {
            if (state.id == widget.poll.id) {
              _onDeleteSuccess();
            }
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: _showTitle ? Text(widget.poll.topic) : null,
            actions: [
              if (widget.poll.status == PollStatus.draft)
                DeleteButton(
                  onTap: _onDeleteTap,
                )
            ],
          ),
          body: PollScreenBody(
            poll: widget.poll,
            confirmedCount: widget.confirmedCount,
            scrollController: _scrollController,
            participantsCount: widget.participantsCount,
          ),
        ),
      );

  // ignore: avoid_void_async

  void _onCancelSuccess() {
    Navigator.pop(context);

    Multiplatform.showMessage<void>(
      context: context,
      title: 'Успешно',
      message: 'Голосование успешно отменено.',
      type: DialogType.success,
    );
  }

  void _onDeleteTap() {
    Multiplatform.showDecisionMessage(
      context: context,
      message: 'Уверены, что хотите удалить голосование?',
      action: () => context.read<PollsListBloc>().add(PollsListDeletePoll(
            id: widget.poll.id,
          )),
    );
  }

  void _onDeleteSuccess() {
    Navigator.pop(context);

    Multiplatform.showMessage<void>(
      context: context,
      title: 'Успешно',
      message: 'Голосование успешно удалено.',
      type: DialogType.success,
    );
  }
}
