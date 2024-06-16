import 'dart:async';

import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/data/routing/routes.dart';
import 'package:bpc/main.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/navigation.dart';
import 'package:bpc/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets.dart';

class ActionButtonRow extends StatelessWidget {
  final Poll poll;
  const ActionButtonRow({
    super.key,
    required this.poll,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SafeArea(
          child: Row(
            children: [
              if (poll.status == PollStatus.draft)
                Expanded(
                  child: ActionButton(
                    icon: Icons.edit_rounded,
                    text: 'Редактир.',
                    onTap: () => _onEditTap(context),
                  ),
                ),
              if (poll.status == PollStatus.publication ||
                  poll.status == PollStatus.inProgress) ...[
                Expanded(
                  child: ActionButton(
                    icon: Icons.block_outlined,
                    text: 'Отменить',
                    onTap: () => _onCancelTap(context),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ActionButton(
                    icon: Icons.notifications_none_rounded,
                    text: 'Оповестить',
                    onTap: () => _onNotifyTap(context),
                  ),
                ),
              ],
            ],
          ),
        ),
      );

  void _onEditTap(BuildContext context) async {
    final value = await Navigation.toPollAdd(
      context: context,
      poll: poll,
      modal: false,
    );
    if (value != null) {
      unawaited(
        getIt<Routes>().pop(),
      );

      unawaited(
        Multiplatform.showMessage<void>(
          context: context,
          title: 'Голосование отредактировано',
          message: '',
          type: DialogType.success,
        ),
      );
    }
  }

  void _onNotifyTap(BuildContext context) {
    Navigation.toPollNotification(
      context: context,
      id: poll.id,
    );
  }

  void _onCancelTap(BuildContext context) {
    Multiplatform.showDecisionMessage(
      context: context,
      message: 'Уверены, что хотите отменить голосование?',
      action: () =>
          context.read<PollsListBloc>().add(PollsListCancelPoll(id: poll.id)),
    );
  }
}
