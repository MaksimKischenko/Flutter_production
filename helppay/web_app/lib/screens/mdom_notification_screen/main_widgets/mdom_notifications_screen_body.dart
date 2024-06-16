import 'package:auto_route/auto_route.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/blocs/blocs.dart';
import 'package:helppay_web_app/routing/routes.gr.dart';
import 'package:helppay_web_app/screens/mdom_notification_screen/widgets/mdom_notifications_list_widget.dart';
import 'package:helppay_web_app/utils/utils.dart';
import 'package:helppay_web_app/widgets/web_dialog_window.dart';

class MdomNotificationsScreenBody extends StatefulWidget {
  final String supplierTitle;
  final int supplierId;

  const MdomNotificationsScreenBody({
    Key? key,
    required this.supplierTitle,
    required this.supplierId,
  }) : super(key: key);

  @override
  _MdomNotificationsScreenBodyState createState() =>
      _MdomNotificationsScreenBodyState();
}

class _MdomNotificationsScreenBodyState
    extends State<MdomNotificationsScreenBody> {
  late List<ResponseNotification>? _notifications = [];
  bool get isListEmpty => _notifications?.isEmpty ?? true;

  @override
  void initState() {
    super.initState();
    final currentAuthState = context.read<AuthBloc>().state;
    if (currentAuthState is AuthAuthorized) {
      _onLoadInfo();
    } else {
      context.read<AuthBloc>().stream.listen((authState) {
        if (authState is AuthAuthorized) {
          _onLoadInfo();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) => WebDialogWindow(
        buttonTitle:
            context.t.mobileScreens.mdomNotificationsScreen.readAllButton,
        useSpacer: false,
        title: context.t.mobileScreens.mdomNotificationsScreen.title,
        body: BlocListener<MdomNotificationsBloc, MdomNotificationsState>(
          listener: (context, state) {
            if (state is MdomNotificationsError) {
            } else if (state is MdomNotificationsErrorKomplat) {
              RequestUtil.catchKomplatError(
                context: context,
                errorCode: state.errorCode,
                errorText: state.errorMessage,
              );
              if (state.errorCode == 403) {
                Future.delayed(
                    const Duration(seconds: 2),
                    () => AutoRouter.of(context).pushAndPopUntil(
                        const MdomAccrualsRoute(),
                        predicate: (route) => false));
              }
            } else if (state is MdomNotificationsLoaded) {
              _successLoad(state.notification);
            } else if (state is MdomNotificationsToggleRefresh) {
            } else if (state is MdomNotificationsLoadedMore) {
              _successLoadedMore(state.notifications);
            }
          },
          child: _notifications?.isNotEmpty ?? false
              ? ListView.builder(
                  // padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: 1,
                  itemBuilder: (context, index) => MdomNotificationWidget(
                    onLoadMorePulled: _onLoadMorePulled,
                    notifications: _notifications!,
                    supplierTitle: widget.supplierTitle,
                  ),
                )
              : Column(
                  children: [
                    Text(context.t.mobileScreens.mdomNotificationsScreen
                        .notificationsListEmpty),
                  ],
                ),
        ),
        onPressed: () {
          context.read<MdomNotificationsBloc>().add(MdomNotificationsReadAll());

          Future.delayed(
            const Duration(milliseconds: 300),
            () => context.read<MdomPollsListBloc>().add(
                  MdomPollsListGetNotificationCount(
                    supplierId: widget.supplierId,
                    participantsCount: context
                        .read<MdomPollsListBloc>()
                        .state
                        .participantsCount,
                    polls: context.read<MdomPollsListBloc>().state.polls,
                  ),
                ),
          );
        },
        buttonActive: !_notifications!.all((element) => element.status == 2),
      );

  void _onLoadInfo() {
    context
        .read<MdomNotificationsBloc>()
        .add(const MdomNotificationsInit(notificationId: 0));
  }

  void _onLoadMorePulled(int notificationListLength) {
    final lastNotificationId =
        (_notifications ?? []).isNotEmpty ? _notifications?.first.id ?? 0 : 0;
    context.read<MdomNotificationsBloc>().add(
          MdomNotificationsLoadMore(
            lastNotificationId: lastNotificationId,
            notificationListLength: notificationListLength,
          ),
        );
  }

  void _successLoadedMore(List<ResponseNotification> notifications) {
    for (final notification in notifications) {
      if (_notifications!.firstOrNullWhere((e) => e.id == notification.id) ==
          null) {
        _notifications?.add(notification);
      }
    }
    setState(() {});
  }

  void _successLoad(List<ResponseNotification?> notifications) {
    setState(() {
      _notifications = List.from(notifications);
    });
  }
}
