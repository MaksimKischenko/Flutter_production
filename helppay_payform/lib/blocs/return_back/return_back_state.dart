part of 'return_back_bloc.dart';

class ReturnBackState extends Equatable {
  final String? backUri;
  
  const ReturnBackState({
    this.backUri,
  });
  
  @override
  List<Object?> get props => [backUri];
}


