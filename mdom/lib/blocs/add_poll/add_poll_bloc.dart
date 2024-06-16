// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'add_poll_event.dart';
part 'add_poll_state.dart';

class AddPollBloc extends Bloc<AddPollEvent, AddPollState> {
  final DataManager dataManager;
  final Poll? poll;

  AddPollBloc({
    required this.dataManager,
    required this.poll,
  }) : super(AddPollInitial()) {
    on<AddPollEvent>(_onEvent);
  }

  void _onEvent(
    AddPollEvent event,
    Emitter<AddPollState> emit,
  ) {
    if (event is AddPollProceed) return _onAddPollProceed(event, emit);
  }

  void _onAddPollProceed(
    AddPollProceed event,
    Emitter<AddPollState> emit,
  ) async {
    emit(AddPollLoading());

    try {
      if (poll != null) {
        final updateTopic = event.topic != poll!.topic;
        final updateStartDate =
            event.startDate != poll!.startDate?.toDateFormatted(withTime: true);
        final updateStopDate =
            event.endDate != poll!.stopDate?.toDateFormatted(withTime: true);
        final updateUrl = event.url != poll!.url;
        final updateAnonymous = event.anonymous != (poll!.anonymous == 1);
        final updateQuestions = !listEquals(
            event.questions, poll!.questions?.map((e) => e.value).toList());
        final newQuestions = updateQuestions
            ? event.questions
                .mapIndexed((e, i) => PollQuestionEdit(
                      idx: i + 1,
                      evalue: e,
                    ))
                .toList()
            : null;

        final response = await dataManager.editPollRequest(
          id: poll!.id,
          topic: updateTopic ? event.topic : null,
          startDate: updateStartDate ? event.startDate : null,
          stopDate: updateStopDate ? event.endDate : null,
          url: updateUrl ? event.url : null,
          anonymous: updateAnonymous ? event.anonymous : null,
          questions: newQuestions,
          publish: event.publish,
        );

        if (response.errorCode == 0) {
          emit(AddPollSuccessEdit(
              poll: poll!.copyWith(
            topic: updateTopic ? event.topic : null,
            startDate: updateStartDate
                ? event.startDate.toStringFormattedWithTime()
                : null,
            stopDate: updateStopDate
                ? event.endDate.toStringFormattedWithTime()
                : null,
            url: updateUrl ? event.url : null,
            anonymous: updateAnonymous ? (event.anonymous ? 1 : 0) : null,
            questions: newQuestions
                ?.map((e) => PollListQuestion(
                      idx: e.idx,
                      value: e.evalue,
                      description: e.description,
                    ))
                .toList(),
          )));
        } else {
          emit(AddPollErrorKomplat(
              errorCode: response.errorCode, errorMessage: response.errorText));
        }
      } else {
        final response = await dataManager.addPollRequest(
          topic: event.topic,
          startDate: event.startDate,
          stopDate: event.endDate,
          url: event.url,
          anonymous: event.anonymous,
          questions: event.questions
              .mapIndexed((e, i) => PollQuestionEdit(
                    idx: i + 1,
                    evalue: e,
                  ))
              .toList(),
          publish: event.publish,
        );

        if (response.errorCode == 0) {
          emit(AddPollSuccessAdd(id: response.id!));
        } else {
          emit(AddPollErrorKomplat(
              errorCode: response.errorCode, errorMessage: response.errorText));
        }
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      emit(AddPollError(error: error));
    }

    emit(AddPollInitial());
  }
}
