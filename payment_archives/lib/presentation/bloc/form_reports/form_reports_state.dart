part of 'form_reports_bloc.dart';

abstract class FormReportsState extends Equatable {
  const FormReportsState();
  
  @override
  List<Object?> get props => [];
}

class FormReportsInitial extends FormReportsState {}

class FormReportsLoading extends FormReportsState {}

class FormReportsSuccess extends FormReportsState {}

class FormReportsError extends FormReportsState {
  final Object? error;

  const FormReportsError({this.error});

  @override
  List<Object?> get props => [error];  
}
