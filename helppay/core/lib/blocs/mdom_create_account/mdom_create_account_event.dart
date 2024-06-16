part of 'mdom_create_account_bloc.dart';

abstract class MdomCreateAccountEvent extends Equatable {
  const MdomCreateAccountEvent();

  @override
  List<Object> get props => [];
}

class MdomCreateAccountInit extends MdomCreateAccountEvent {
  final int supplierId;
  final String account;
  final String? codeWord;

  const MdomCreateAccountInit({
    required this.supplierId,
    required this.account,
    this.codeWord,
  });

  @override
  List<Object> get props => [supplierId, account];
}
