import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/data/routing/routes.gr.dart';
import 'package:bpc/injection_component.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/screens/screens.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/widgets.dart';


@RoutePage()
class PollMembersScreen extends StatefulWidget {
  // static const pageRoute = '/polls/members';
  static const pageRoute = '${PollsListScreen.pageRoute}/:members';

  final int participantsCount;
  final int confirmedCount;
  final Poll poll;

  const PollMembersScreen({
    Key? key,
    required this.participantsCount,
    required this.confirmedCount,
    required this.poll,
  }) : super(key: key);

  @override
  State<PollMembersScreen> createState() => _PollMembersScreenState();
}

class _PollMembersScreenState extends State<PollMembersScreen> {
  late ScrollController _scrollController;

  double get titleSize => 40;

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
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider<PollMembersBloc>(
        create: (context) => PollMembersBloc(
          dataManager: InjectionComponent.getDependency<DataManager>(),
          id: widget.poll.id,
        )..add(PollMembersInit()),
        child: Scaffold(
          appBar: AppBar(
            leadingWidth: 84,
            leading: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Row(
                children: const [
                  Icon(CupertinoIcons.chevron_left),
                  Text(
                    'Назад',
                    // TODO
                    // context.t.screens.mdomPollsListFilters.cancelButton,
                  ),
                ],
              ),
            ),
            title: _showTitle
                ? const Text(
                    'Участники',
                    // TODO
                    // context.t.screens.mdomPollsListFilters.title,
                  )
                : null,
          ),
          body: WebConstrainedBox(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                      padding: EdgeInsets.fromLTRB(16, 4, 16, 32),
                      child: PageTitle(
                        text: 'Участники',
                        // TODO
                        // text: context.t.screens.mdomPollsListFilters.title
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Все лицевые счета / Подтвержденные',
                            style: TextStyle(
                              color: AppStyles.mainTextColor.withOpacity(.5),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                            '${widget.poll.status == PollStatus.completed ? widget.poll.participantsCount : widget.participantsCount} / ${widget.poll.status == PollStatus.completed ? widget.poll.confirmedCount : widget.confirmedCount}')
                      ],
                    ),
                  ),
                  BlocBuilder<PollMembersBloc, PollMembersState>(
                    builder: (context, state) {
                      Widget? body;

                      if (state is PollMembersLoading) {
                        body = const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: LoadingIndicator(),
                          ),
                        );
                      } else if (state is PollMembersError) {
                        body = Error(context,
                            message: state.error.toString(),
                            onRepeatTap: () => context
                                .read<PollMembersBloc>()
                                .add(PollMembersInit()));
                      } else if (state is PollMembersErrorKomplat) {
                        body = Error(context,
                            message: state.errorMessage ?? 'Ошибка',
                            // TODO
                            // message: state.errorMessage ?? context.t.screens.mdomPollStatisticsQuestion.errorMessage,
                            onRepeatTap: () => context
                                .read<PollMembersBloc>()
                                .add(PollMembersInit()));
                        if (state.errorCode == 119) {
                          Future.delayed(
                            const Duration(seconds: 2),
                            () =>
                                AutoRouter.of(context).push(const AuthRoute()),
                          );
                        }
                      } else if (state is PollMembersLoaded) {
                        if (state.members.isNotEmpty) {
                          final confirmedMembers = (List<Member>.from(state
                                  .members
                                  .where((member) => member.confirmed == 1))
                                ..sort((a, b) => int.parse(a.clientAccount)
                                    .compareTo(int.parse(b.clientAccount))))
                              .toList();
                          final unconfirmedMembers = (List<Member>.from(state
                                  .members
                                  .where((member) => member.confirmed != 1))
                                ..sort((a, b) => int.parse(a.clientAccount)
                                    .compareTo(int.parse(b.clientAccount))))
                              .toList();
                          final members = [
                            ...confirmedMembers,
                            ...unconfirmedMembers
                          ];

                          body = SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.separated(
                                  itemBuilder: (context, index) => MemberItem(
                                    item: members[index],
                                  ),
                                  itemCount: members.length,
                                  separatorBuilder: (context, _) => Padding(
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      top: 4,
                                      bottom: 4,
                                    ),
                                    child: Divider(
                                      color: AppStyles.mainTextColor
                                          .withOpacity(.5),
                                      height: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      }

                      return body ?? const SizedBox.shrink();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
