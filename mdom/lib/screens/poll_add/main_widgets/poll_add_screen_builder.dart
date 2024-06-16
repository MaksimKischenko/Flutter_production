import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/screens/poll_add/widgets/widgets.dart';
import 'package:bpc/utils/utils.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class PolAddScreenBuilder extends StatefulWidget {
  final Poll? poll;
  const PolAddScreenBuilder({required this.poll, super.key});

  @override
  State<PolAddScreenBuilder> createState() => _PolAddScreenBuilderState();
}

class _PolAddScreenBuilderState extends State<PolAddScreenBuilder> {
  final _formKey = GlobalKey<FormState>();

  late ScrollController _scrollController;
  final _topicController = TextEditingController();
  final _startDateController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endDateController = TextEditingController();
  final _endTimeController = TextEditingController();
  final _urlController = TextEditingController();

  double get titleSize => 40;

  bool _isTitleVisible = false;

  bool get _showTitle =>
      _scrollController.hasClients && _scrollController.offset - titleSize > 0;

  bool get isPublishAvaiable {
    if (_topicController.text.trim().isEmpty) return false;
    if (_startDate == null) return false;
    if (_endDate == null) return false;
    if (_questions.isEmpty) return false;
    if (_questions.where((e) => e.text.isEmpty).isNotEmpty) return false;
    if (widget.poll != null) return !isDataOld;
    return true;
  }

  bool get isCreateAvaiable {
    if (_topicController.text.trim().isEmpty) return false;
    if (_startDate == null) return false;
    if (_endDate == null) return false;
    if (widget.poll != null) return !isDataOld;
    return true;
  }

  bool get isDataOld {
    // no one of old fields has edited
    final oldQuestions = widget.poll?.questions?.map((e) => e.value).toList();
    final newQuestions = _questions.map((e) => e.text).toList();

    if (_topicController.text == widget.poll?.topic &&
        _startDate == widget.poll?.startDate?.toDateFormatted(withTime: true) &&
        _endDate == widget.poll?.stopDate?.toDateFormatted(withTime: true) &&
        _anonymous == (widget.poll?.anonymous == 1) &&
        listEquals(oldQuestions, newQuestions)) return true;

    return false;
  }

  DateTime? _startDate;
  DateTime? _endDate;
  bool _anonymous = false;
  List<NewQuestionWrapper> _questions = [];

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

    if (widget.poll != null) {
      _topicController.text = widget.poll!.topic;
      _startDate = widget.poll!.startDate?.toDateFormatted(withTime: true);
      _endDate = widget.poll!.stopDate?.toDateFormatted(withTime: true);
      _urlController.text = widget.poll!.url ?? '';
      _anonymous = widget.poll!.anonymous == 1;
      _questions = widget.poll!.questions
              ?.map((e) => NewQuestionWrapper(
                  key: Key(getRandString(20)), text: e.value))
              .toList() ??
          [];

      _updateStartDateText();
      _updateEndDateText();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _topicController.dispose();
    _startDateController.dispose();
    _startTimeController.dispose();
    _endDateController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return BlocListener<AddPollBloc, AddPollState>(
      listener: (context, state) {
        if (state is AddPollError) {
        } else if (state is AddPollErrorKomplat) {
          RequestUtil.catchKomplatError(
            context: context,
            errorCode: state.errorCode,
            errorText: state.errorMessage,
          );
        } else if (state is AddPollSuccessAdd) {
          _onPollSuccessCreate(
            id: state.id,
          );
        } else if (state is AddPollSuccessEdit) {
          _onPollSuccessEdit(state.poll);
        }
      },
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
              ? Text(
                  widget.poll == null
                      ? 'Новое голосование'
                      : 'Редактирование голосования',
                  // TODO
                  // context.t.screens.mdomPollsListFilters.title,
                )
              : null,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
                        child: PageTitle(
                          text: widget.poll == null
                              ? 'Новое голосование'
                              : 'Редактирование голосования',
                          // TODO
                          // text: context.t.screens.mdomPollsListFilters.title
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TopicTextField(
                          controller: _topicController,
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: DatePickerField(
                                  controller: _startDateController,
                                  label: 'Начало*',
                                  initialDate: _startDate,
                                  onChanged: _onStartDateChanged,
                                  validator: () {
                                    if (_startDate == null) {
                                      return 'Ошибка';
                                    }
                                    if (_endDate == null) return 'Ошибка';
                                    if (_startDate!.isBefore(DateTime.now())) {
                                      return 'Дата начала до текущей даты';
                                    }
                                    if (_startDate!.isAfter(_endDate!)) {
                                      return 'Ошибка';
                                    }
                                    return null;
                                  }),
                            ),
                            if (_startDate != null)
                              Container(
                                padding: const EdgeInsets.only(left: 8),
                                width: 100,
                                child: TimePickerField(
                                  controller: _startTimeController,
                                  initialDate: _startDate,
                                  onChanged: _onStartTimeChanged,
                                ),
                              )
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: DatePickerField(
                                  controller: _endDateController,
                                  label: 'Окончание*',
                                  initialDate: _endDate,
                                  onChanged: _onEndDateChanged,
                                  validator: () {
                                    if (_startDate == null) {
                                      return 'Ошибка';
                                    }
                                    if (_endDate == null) return 'Ошибка';
                                    if (_endDate!.isBefore(_startDate!)) {
                                      return 'Ошибка';
                                    }
                                    return null;
                                  }),
                            ),
                            if (_endDate != null)
                              Container(
                                padding: const EdgeInsets.only(left: 8),
                                width: 100,
                                child: TimePickerField(
                                  controller: _endTimeController,
                                  initialDate: _endDate,
                                  onChanged: _onEndTimeChanged,
                                ),
                              )
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: UrlTextField(
                          controller: _urlController,
                        ),
                      ),
                      const SizedBox(height: 16),
                      AnonymousPicker(
                        value: _anonymous,
                        onChange: _onAnonymousChange,
                      ),
                      const SizedBox(height: 16),
                      if (_questions.isNotEmpty)
                        SlidableAutoCloseBehavior(
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            itemCount: _questions.length,
                            itemBuilder: (context, index) => QuestionTextField(
                              index: index,
                              value: _questions[index],
                              onChanged: (value) =>
                                  _onQuestionChanged(index, value),
                              onDismissed: (index) => setState(() {
                                _questions.removeAt(index);
                              }),
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 4),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: AddQuestionButton(
                          onTap: _onAddQuestionTap,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SafeArea(
                child: Column(
                  children: [
                    if (isPublishAvaiable)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: CreateButton(
                          text: widget.poll == null
                              ? 'Создать и опубликовать'
                              : 'Сохранить и опубликовать',
                          secondary: true,
                          onTap: () => _validateAndSendForm(
                            publish: true,
                          ),
                        ),
                      ),
                    CreateButton(
                      active: isCreateAvaiable,
                      text: widget.poll == null ? 'Создать' : 'Сохранить',
                      onTap: _validateAndSendForm,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onStartDateChanged(DateTime value) {
    setState(() {
      _startDate = DateTime(value.year, value.month, value.day);
    });
    _updateStartDateText();
  }

  void _onStartTimeChanged(DateTime value) {
    setState(
      () {
        _startDate = DateTime(
          _startDate!.year,
          _startDate!.month,
          _startDate!.day,
          value.hour,
        );
      },
    );
    _updateStartDateText();
  }

  void _onEndDateChanged(DateTime value) {
    setState(() {
      _endDate = DateTime(value.year, value.month, value.day);
    });
    _updateEndDateText();
  }

  void _onEndTimeChanged(DateTime value) {
    setState(() {
      _endDate =
          DateTime(_endDate!.year, _endDate!.month, _endDate!.day, value.hour);
    });
    _updateEndDateText();
  }

  void _updateStartDateText() {
    _startDateController.text = _startDate?.toStringFormatted() ?? '';
    _startTimeController.text = DateFormat('HH:mm').format(_startDate!);
  }

  void _updateEndDateText() {
    _endDateController.text = _endDate?.toStringFormatted() ?? '';
    _endTimeController.text = DateFormat('HH:mm').format(_endDate!);
  }

  void _onAnonymousChange(bool value) {
    setState(() {
      _anonymous = value;
    });
  }

  void _onQuestionChanged(int index, String value) {
    setState(() {
      _questions[index] = _questions[index].copyWith(text: value);
    });
  }

  void _onAddQuestionTap() {
    setState(() {
      _questions.add(NewQuestionWrapper(
        key: Key(DateTime.now().toString()),
        text: '',
      ));
    });
  }

  // void _onPublishTap() {
  //   _validateAndSendForm(publish: true);
  // }

  // void _onCreateTap(con) {
  //   _validateAndSendForm();
  // }

  void _validateAndSendForm({
    bool publish = false,
  }) {
    if (_formKey.currentState?.validate() ?? false) {
      // _formKey.currentState?.save();
      context.read<AddPollBloc>().add(
            AddPollProceed(
              topic: _topicController.text.trim(),
              startDate: _startDate!,
              endDate: _endDate!,
              url: _urlController.text.isNotEmpty ? _urlController.text : null,
              anonymous: _anonymous,
              questions: _questions.map((e) => e.text).toList(),
              publish: publish,
            ),
          );
    }
  }

  void _onPollSuccessCreate({
    required int id,
  }) {
    Navigator.pop(context);

    Multiplatform.showMessage<void>(
      context: context,
      title: 'Голосование создано!',
      message: '',
      type: DialogType.success,
    );
  }

  void _onPollSuccessEdit(Poll poll) {
    context.read<PollsListBloc>().add(PollsListEditPoll(
          poll: poll,
        ));
    Navigator.of(context).pop<Poll>(poll);
  }
}
