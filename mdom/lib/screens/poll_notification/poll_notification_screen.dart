import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/widgets.dart';

class PollNotificationScreen extends StatefulWidget {
  final int id;
  //TODO need separated routeName

  const PollNotificationScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<PollNotificationScreen> createState() => _PollNotificationScreenState();
}

class _PollNotificationScreenState extends State<PollNotificationScreen> {
  final _formKey = GlobalKey<FormState>();

  late ScrollController _scrollController;
  late TextEditingController _messageController;

  double get titleSize => 40;

  bool get isSendAvaiable {
    if (_messageController.text.trim().isEmpty) return false;
    return true;
  }

  @override
  void initState() {
    super.initState();

    _messageController = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<PollsListBloc, PollsListState>(
        listener: (context, state) {
          if (state is PollListNotifyPollSuccess) {
            if (state.id == widget.id) {
              _onNotifySuccess();
            }
          } else if (state is PollsListErrorKomplat) {
            RequestUtil.catchKomplatError(
                context: context,
                errorCode: state.errorCode,
                errorText: state.errorMessage);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leadingWidth: 20,
            leading: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Icon(CupertinoIcons.chevron_left),
            ),
            title: const Center(
              child: Text(
                'Оповещение',
                // TODO
                // context.t.screens.mdomPollsListFilters.title,
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          MessageTextField(
                            controller: _messageController,
                            onChanged: (_) => setState(() {}),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SafeArea(
                  child: SendButton(
                    active: isSendAvaiable,
                    onTap: _onSendTap,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  void _onSendTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<PollsListBloc>().add(PollsListNotifyPoll(
          id: widget.id, message: _messageController.text.trim()));
    }
  }

  void _onNotifySuccess() {
    Navigator.pop(context);

    Multiplatform.showMessage<void>(
      context: context,
      title: '',
      message: 'Оповещение отправлено всем участникам',
      type: DialogType.success,
    );
  }
}
