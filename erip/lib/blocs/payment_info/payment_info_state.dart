part of 'payment_info_bloc.dart';

abstract class PaymentInfoState extends Equatable {
  const PaymentInfoState();
  
  @override
  List<Object> get props => [];
}

class PaymentInfoLoading extends PaymentInfoState {}

class PaymentInfoInitial extends PaymentInfoState {
  final Map<String, dynamic> info;

  const PaymentInfoInitial({
    required this.info
  });

  @override
  List<Object> get props => [info];

}
