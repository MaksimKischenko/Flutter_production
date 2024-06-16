part of 'intro_message_bloc.dart';

abstract class IntroMessageEvent extends Equatable {
  const IntroMessageEvent();

  @override
  List<Object> get props => [];
}


class IntroMessageSave extends IntroMessageEvent {
  final String message;
  
  const IntroMessageSave({
    required this.message,
  });

  @override
  List<Object> get props => [message];
  
}

