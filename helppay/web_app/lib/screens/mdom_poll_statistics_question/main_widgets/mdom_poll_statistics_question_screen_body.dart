import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/screens/mdom_poll_statistics_question/widgets/widgets.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

class MdomPollStatisticsQuestionScreenBody extends StatefulWidget {
  final PollListQuestion question;

  const MdomPollStatisticsQuestionScreenBody({
    Key? key,
    required this.question,
  }) : super(key: key);

  @override
  State<MdomPollStatisticsQuestionScreenBody> createState() =>
      _MdomPollStatisticsQuestionScreenBodyState();
}

class _MdomPollStatisticsQuestionScreenBodyState
    extends State<MdomPollStatisticsQuestionScreenBody> {
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
        body: Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 40),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 720,
                ),
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
            ),
          ),
        ),
      );
}
