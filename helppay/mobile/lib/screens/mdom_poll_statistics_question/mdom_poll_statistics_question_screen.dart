import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets/widgets.dart';

class MdomPollStatisticsQuestionScreen extends StatefulWidget {
  static const pageRoute = '/poll/statistics/question';

  final PollListQuestion question;

  const MdomPollStatisticsQuestionScreen({
    Key? key,
    required this.question,
  }) : super(key: key);

  @override
  State<MdomPollStatisticsQuestionScreen> createState() =>
      _MdomPollStatisticsQuestionScreenState();
}

class _MdomPollStatisticsQuestionScreenState
    extends State<MdomPollStatisticsQuestionScreen> {
  late ScrollController _scrollController;

  double get titleSize => 40;

  bool _isTitleVisible = false;

  bool get _showTitle =>
      _scrollController.hasClients && _scrollController.offset - titleSize > 0;

  int get votedCount =>
      (widget.question.positiveCount ?? 0) +
      (widget.question.negativeCount ?? 0) +
      (widget.question.abstainedCount ?? 0);

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
                  widget.question.value,
                  style: const TextStyle(color: AppStyles.mainColorDark),
                )
              : null,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
                  child: PageTitle(text: widget.question.value)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: RichText(
                  text: TextSpan(
                    text:
                        '${context.t.mobileScreens.mdomPollStatisticsQuestion.votedText}: ',
                    style: TextStyle(
                      color: AppStyles.mainTextColor.withOpacity(.5),
                    ),
                    children: [
                      TextSpan(
                        text: votedCount.toString(),
                        style: const TextStyle(
                          color: AppStyles.mainTextColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const PollQuestionInfoBoby(),
            ],
          ),
        ),
      );
}
