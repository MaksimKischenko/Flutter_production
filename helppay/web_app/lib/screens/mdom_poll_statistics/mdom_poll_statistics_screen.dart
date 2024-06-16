import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/routing/routes.gr.dart';
import 'package:helppay_web_app/styles.dart';

import 'widgets/widgets.dart';

@RoutePage<Poll>()
class MdomPollStatisticsScreen extends StatefulWidget {
  static const PageInfo<dynamic> routePage = PageInfo('/statistics');

  static const pageRoute = '/statistics';

  final int? participantsCount;
  final Poll? poll;

  const MdomPollStatisticsScreen({
    Key? key,
    @PathParam('count') this.participantsCount,
    this.poll,
  }) : super(key: key);

  @override
  State<MdomPollStatisticsScreen> createState() =>
      _MdomPollStatisticsScreenState();
}

class _MdomPollStatisticsScreenState extends State<MdomPollStatisticsScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _windowHistoryBack();
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text(
          context.t.mobileScreens.mdomPollStatistics.title,
          style: const TextStyle(
            color: AppStyles.mainColorDark,
          ),
        ),
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 40),
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 720,
              ),
              child: PollStatisticsScreenBody(
                poll: widget.poll ?? Poll.empty(),
                participantsCount: widget.participantsCount ?? 0,
                scrollController: _scrollController,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _windowHistoryBack() async {
    if (widget.poll == null) {
      await AutoRouter.of(context).popAndPush(const MdomAccrualsRoute());
    }
  }
}
