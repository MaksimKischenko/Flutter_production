part of 'info_bloc.dart';

abstract class InfoState extends Equatable {
  const InfoState();
  
  @override
  List<Object> get props => [];
}

class InfoLoading extends InfoState {}

class InfoLoaded extends InfoState {
  final Map<String, dynamic> mainInfoList;
  final List<Contact> contactsList;
  final List<Service> servicesList;

  const InfoLoaded({
    required this.mainInfoList,
    required this.contactsList,
    required this.servicesList
  });

  @override
  List<Object> get props => [mainInfoList, contactsList, servicesList];
}
