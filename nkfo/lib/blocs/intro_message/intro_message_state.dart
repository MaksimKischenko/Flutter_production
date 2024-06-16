part of 'intro_message_bloc.dart';


abstract class IntroMessageState extends Equatable {
  const IntroMessageState();
  
  @override
  List<Object?> get props => [];
}

class IntroMessageInitial extends IntroMessageState {}

class IntroMessageLoading extends IntroMessageState{}

class IntroMessageError extends IntroMessageState {
  final Object? error;

  const IntroMessageError({this.error});

  @override
  List<Object?> get props => [error];
}

class IntroMessageSuccess extends IntroMessageState{}