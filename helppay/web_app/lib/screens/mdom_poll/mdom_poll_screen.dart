import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/injection_component.dart';
import 'package:helppay_web_app/screens/mdom_poll/main_widgets/mdom_poll_screen_main_body.dart';

@RoutePage<Poll>()
class MdomPollScreen extends StatelessWidget {
  static const PageInfo<dynamic> routePage = PageInfo('/poll');

  static const pageRoute = '/poll';

  final int? participantsCount;
  final String? supplierTitle;
  final Poll? poll;

  const MdomPollScreen({
    Key? key,
    @PathParam('count') this.participantsCount,
    @PathParam('title') this.supplierTitle,
    this.poll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _windowHistoryBack(context);
    return BlocProvider<VotePollBloc>(
      create: (context) => VotePollBloc(
          dataManager: InjectionComponent.getDependency<DataManager>(),
          poll: poll ?? Poll.empty())
        ..add(VotePollInit()),
      child: MdomPollScreenMainBody(
          participantsCount: participantsCount ?? 0,
          supplierTitle: !(supplierTitle ?? '').contains('%')
              ? supplierTitle ?? ''
              : Uri.decodeComponent(supplierTitle ?? ''),
          poll: poll ?? Poll.empty()),
    );
  }

  Future<void> _windowHistoryBack(BuildContext context) async {
    if (poll == null) {
      AutoRouter.of(context).back();
    }
  }
}
