import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/injection_component.dart';
import 'package:helppay_web_app/routing/routes.gr.dart';
import 'package:helppay_web_app/screens/mdom_poll_statistics_question/main_widgets/mdom_poll_statistics_question_screen_body.dart';

@RoutePage()
class MdomPollStatisticsQuestionScreen extends StatelessWidget {
  static const PageInfo<dynamic> routePage = PageInfo('/question');

  static const pageRoute = '/question';

  final PollListQuestion? question;
  final int? pollId;

  const MdomPollStatisticsQuestionScreen({
    Key? key,
    @PathParam('id') this.pollId,
    this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _windowHistoryBack(context);
    return BlocProvider<MdomPollQuestionInfoBloc>(
      create: (context) => MdomPollQuestionInfoBloc(
          dataManager: InjectionComponent.getDependency<DataManager>(),
          pollId: pollId ?? 0,
          questionId: question?.idx ?? 0)
        ..add(MdomPollQuestionInfoInit()),
      child: MdomPollStatisticsQuestionScreenBody(
        question: question ?? const PollListQuestion(value: '', idx: 0),
      ),
    );
  }

  Future<void> _windowHistoryBack(BuildContext context) async {
    if (question == null) {
      await AutoRouter.of(context).popAndPush(const MdomAccrualsRoute());
    }
  }
}
