part of 'info_bloc.dart';

abstract class InfoState extends Equatable {
  const InfoState();
  
  @override
  List<Object> get props => [];
}

class InfoLoading extends InfoState {}

class InfoLoaded extends InfoState {
  final Map<String, dynamic> main;
  final Map<String, dynamic> contacts;
  final List<Service> services;

  const InfoLoaded({
    required this.main,
    required this.contacts,
    required this.services
  });

  @override
  List<Object> get props => [main, contacts, services];
}
