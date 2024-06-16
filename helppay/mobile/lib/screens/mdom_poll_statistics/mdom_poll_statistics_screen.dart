import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets/widgets.dart';

class MdomPollStatisticsScreen extends StatefulWidget {
  static const pageRoute = '/poll/statistics';

  final int participantsCount;
  final Poll poll;

  const MdomPollStatisticsScreen({
    Key? key,
    required this.participantsCount,
    required this.poll,
  }) : super(key: key);

  @override
  State<MdomPollStatisticsScreen> createState() =>
      _MdomPollStatisticsScreenState();
}

class _MdomPollStatisticsScreenState extends State<MdomPollStatisticsScreen> {
  late ScrollController _scrollController;

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
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: _showTitle
              ? Text(
                  // widget.poll.topic,
                  context.t.mobileScreens.mdomPollStatistics.title,
                  style: const TextStyle(
                    color: AppStyles.mainColorDark,
                  ),
                )
              : null,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: PollStatisticsScreenBody(
          poll: widget.poll,
          participantsCount: widget.participantsCount,
          scrollController: _scrollController,
        ),
      );
}
