part of 'return_back_bloc.dart';

abstract class ReturnBackEvent extends Equatable {
  const ReturnBackEvent();

  @override
  List<Object?> get props => [];
}

class ReturnBackInit extends ReturnBackEvent {
  final String? returnUri;
  
  ReturnBackInit({
    required this.returnUri,
  });

  @override
  List<Object?> get props => [returnUri];
}
