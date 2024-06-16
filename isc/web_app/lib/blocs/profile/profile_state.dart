part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {
  final String email;
  final String username;
  final List<MdomResponseParam> userParams;


  const ProfileInitial({
    required this.email,
    required this.username,
    required this.userParams,
  });

  @override
  List<Object?> get props => [email, username, userParams];
}

class ProfileLoading extends ProfileState {}



