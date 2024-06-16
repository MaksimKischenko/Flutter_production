import 'package:auto_route/auto_route.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/widgets.dart';


@RoutePage()
class PollStatisticsScreen extends StatefulWidget {
  // static const pageRoute = '/poll/statistics';
  static const pageRoute = '${PollScreen.pageRoute}/:statistics';

  final int participantsCount;
  final int confirmedCount;
  final Poll poll;

  const PollStatisticsScreen({
    Key? key,
    required this.participantsCount,
    required this.confirmedCount,
    required this.poll,
  }) : super(key: key);

  @override
  State<PollStatisticsScreen> createState() => _PollStatisticsScreenState();
}

class _PollStatisticsScreenState extends State<PollStatisticsScreen> {
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
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: _showTitle
              ? const Text(
                  'Вопросы',
                  // TODO
                  // widget.poll.topic,
                )
              : null,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: PollStatisticQuestinList(
            confirmedCount: widget.confirmedCount,
            participantsCount: widget.participantsCount,
            poll: widget.poll,
          ),
        ),
      );
}
