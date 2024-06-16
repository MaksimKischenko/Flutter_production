import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay/blocs/blocs.dart';
import 'package:helppay/screens/mdom_notification_screen/widgets/mdom_notifications_button.dart';
import 'package:helppay/screens/mdom_notification_screen/widgets/mdom_notifications_list_widget.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// import 'widgets/widgets.dart';
// void _log(dynamic message) =>
//     Logger.helpPayLog(message, name: 'mdom_notification_screen');

class MdomNotificationsScreen extends StatefulWidget {
  static const pageRoute = '/notifications';
  final String supplierTitle;
  final int supplierId;
  const MdomNotificationsScreen({
    Key? key,
    required this.supplierTitle,
    required this.supplierId,
  }) : super(key: key);

  @override
  _MdomNotificationsScreenState createState() =>
      _MdomNotificationsScreenState();
}

class _MdomNotificationsScreenState extends State<MdomNotificationsScreen> {
  late ScrollController _scrollController;

  var _isVisible = true;

  RefreshController refreshController = RefreshController(
      initialRefresh: true //CoreConfig.appFlavour == AppFlavour.mdom,
      );

  late List<ResponseNotification>? _notifications = [];
  bool get isListEmpty => _notifications?.isEmpty ?? true;
  double get titleSize => 40;
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
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible) {
          _isVisible = false;
          context.read<MenuBloc>().add(MenuHide());
        }
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isVisible) {
          _isVisible = true;
          context.read<MenuBloc>().add(MenuShow());
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: _showTitle
              ? Text(
                  context.t.mobileScreens.mdomNotificationsScreen.title,
                  style: const TextStyle(
                    color: AppStyles.mainColorDark,
                  ),
                )
              : null,
          leading: IconButton(
            icon: SvgPicture.asset(
              'assets/icon/arrow_back.svg',
              colorFilter: const ColorFilter.mode(AppStyles.mainColorDark, BlendMode.srcIn),
            ),
            iconSize: 24,
            onPressed: () {
              if (!_notifications!.all((element) => element.status == 2)) {
                context.read<MdomNotificationsBloc>().add(
                      MdomNotificationsReadAll(),
                    );
                Future.delayed(const Duration(milliseconds: 500),
                    () => Navigator.pop(context, true));
              } else {
                Navigator.pop(context);
              }
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: BlocListener<MdomNotificationsBloc, MdomNotificationsState>(
          listener: (context, state) {
            if (state is MdomNotificationsError) {
              _catchErrorToRefreshController();
            } else if (state is MdomNotificationsErrorKomplat) {
              final isTokenError = state.errorCode == 403;
              _catchErrorToRefreshController();
              if (!isTokenError) {
                RequestUtil.catchKomplatError(
                  context: context,
                  errorCode: state.errorCode,
                  errorText: state.errorMessage,
                );
              }
              if (isTokenError) {
                // Future<void>.delayed(const Duration(seconds: 1),
                //     () => Navigation.navigatorKey.currentState?.pop());
                Multiplatform.onExpiredTokenScreenLock(context);
              }
            } else if (state is MdomNotificationsLoaded) {
              _successLoad(state.notification);
            } else if (state is MdomNotificationsToggleRefresh) {
              refreshController.requestRefresh();
            } else if (state is MdomNotificationsLoadedMore) {
              _successLoadedMore(state.notifications);
            }
          },
          child: SmartRefresher(
            //bottomSafe: false,
            //scrollController: _scrollController,
            primary: false,
            controller: refreshController,
            onRefresh: _onRefresh,
            onLoading: () => _onLoadMorePulled(_notifications?.length ?? 0),
            enablePullDown: true,
            enablePullUp: true,
            header: const RefreshHeader(),
            child: _notifications?.isNotEmpty ?? false
                ? Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          itemCount: 1,
                          itemBuilder: (context, index) =>
                              MdomNotificationWidget(
                            notifications: _notifications!,
                            supplierTitle: widget.supplierTitle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: MdomNotificationsButton(
                          enableButton: !_notifications!
                              .all((element) => element.status == 2),
                          onTap: () {
                            context.read<MdomNotificationsBloc>().add(
                                  MdomNotificationsReadAll(),
                                );
                            context.read<MdomPollsListBloc>().add(
                                  MdomPollsListGetNotificationCount(
                                    supplierId: widget.supplierId,
                                    participantsCount: context
                                        .read<MdomPollsListBloc>()
                                        .state
                                        .participantsCount,
                                    polls: context
                                        .read<MdomPollsListBloc>()
                                        .state
                                        .polls,
                                  ),
                                );
                          },
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Text(context.t.mobileScreens.mdomNotificationsScreen
                          .notificationsListEmpty),
                    ],
                  ),
          ),
        ),
      );

  void _onRefresh() {
    context
        .read<MdomNotificationsBloc>()
        .add(const MdomNotificationsInit(notificationId: 0));
  }

  void _catchErrorToRefreshController() {
    refreshController.refreshFailed();
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
    if (notifications.isEmpty) {
      refreshController.loadNoData();
    } else {
      if (notifications.length < CoreConfig.notificationsListRequestLoadCount) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
      for (final notification in notifications) {
        if (_notifications!.firstOrNullWhere(
                (ResponseNotification e) => e.id == notification.id) ==
            null) {
          _notifications?.add(notification);
        }
      }
      setState(() {
        // _pollsList!.addAll(polls);
      });
    }
  }

  void _successLoad(List<ResponseNotification?> notifications) {
    refreshController.resetNoData();

    setState(() {
      _notifications = List.from(notifications);
    });

    if (isListEmpty) {
      refreshController.refreshToIdle();
    } else {
      refreshController.refreshCompleted();
    }
  }
}
