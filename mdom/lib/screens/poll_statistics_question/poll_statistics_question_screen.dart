import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/injection_component.dart';
import 'package:bpc/screens/screens.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/utils/loger.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/widgets.dart';



@RoutePage()
class PollStatisticsQuestionScreen extends StatefulWidget {
  // static const pageRoute = '/poll/statistics/question';
  static const pageRoute = '${PollStatisticsScreen.pageRoute}/:question';

  final int pollId;

  final PollListQuestion question;

  const PollStatisticsQuestionScreen({
    Key? key,
    required this.question,
    required this.pollId,
  }) : super(key: key);

  @override
  State<PollStatisticsQuestionScreen> createState() =>
      _PollStatisticsQuestionScreenState();
}

class _PollStatisticsQuestionScreenState
    extends State<PollStatisticsQuestionScreen> {
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
  Widget build(BuildContext context) => BlocProvider<PollQuestionInfoBloc>(
        create: (context) => PollQuestionInfoBloc(
            dataManager: InjectionComponent.getDependency<DataManager>(),
            pollId: widget.pollId,
            questionId: widget.question.idx)
          ..add(PollQuestionInfoInit()),
        child: Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: _showTitle
                ? Text(
                    widget.question.value,
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
                  child: PageTitle(text: widget.question.value),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    text: TextSpan(
                      text: 'Всего проголосовало: ',
                      // TODO
                      // text: '${context.t.screens.mdomPollStatisticsQuestion.votedText}: ',
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
                BlocBuilder<PollQuestionInfoBloc, PollQuestionInfoState>(
                  builder: (context, state) {
                    Widget? body;
                    if (state is PollQuestionInfoLoading) {
                      body = const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Center(
                          child: LoadingIndicator(),
                        ),
                      );
                    } else if (state is PollQuestionInfoError) {
                      body = Error(context,
                          message: state.error.toString(),
                          onRepeatTap: () => context
                              .read<PollQuestionInfoBloc>()
                              .add(PollQuestionInfoInit()));
                    } else if (state is PollQuestionInfoErrorKomplat) {
                      body = Error(context,
                          message: state.errorMessage ?? 'Ошибка',
                          // TODO
                          // message: state.errorMessage ?? context.t.screens.mdomPollStatisticsQuestion.errorMessage,
                          onRepeatTap: () => context
                              .read<PollQuestionInfoBloc>()
                              .add(PollQuestionInfoInit()));
                    } else if (state is PollQuestionInfoLoaded) {
                      // _log('${state.positiveAnswers}');
                      // _log('${state.negativeAnswers}');
                      // _log('${state.abstainAnswers}');
                      state.positiveAnswers.sort((a, b) =>
                          int.parse(a.clientAccount ?? '')
                              .compareTo(int.parse(b.clientAccount ?? '')));
                      body = Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (state.positiveAnswers.isNotEmpty)
                            const ListTitle(
                              'Да',
                              // TODO
                              // context.t.screens.mdomPollStatisticsQuestion.answersTitle.yes
                            ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(top: 12, bottom: 24),
                            itemCount: state.positiveAnswers.length,
                            itemBuilder: (context, index) => AnswerItem(
                              item: state.positiveAnswers[index],
                            ),
                            separatorBuilder: (context, _) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Separator(),
                            ),
                          ),
                          if (state.negativeAnswers.isNotEmpty)
                            const ListTitle(
                              'Нет',
                              // TODO
                              // context.t.screens.mdomPollStatisticsQuestion.answersTitle.no
                            ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(top: 12, bottom: 24),
                            itemCount: state.negativeAnswers.length,
                            itemBuilder: (context, index) => AnswerItem(
                              item: state.negativeAnswers[index],
                            ),
                            separatorBuilder: (context, _) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Separator(),
                            ),
                          ),
                          if (state.abstainAnswers.isNotEmpty)
                            const ListTitle(
                              'Воздержались',
                              // TODO
                              // context.t.screens.mdomPollStatisticsQuestion.answersTitle.abstain
                            ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(top: 12, bottom: 24),
                            itemCount: state.abstainAnswers.length,
                            itemBuilder: (context, index) => AnswerItem(
                              item: state.abstainAnswers[index],
                            ),
                            separatorBuilder: (context, _) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Separator(),
                            ),
                          ),
                        ],
                      );
                    }

                    return body ?? const SizedBox.shrink();
                  },
                )
              ],
            ),
          ),
        ),
      );
}
