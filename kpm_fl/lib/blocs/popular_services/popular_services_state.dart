part of 'popular_services_bloc.dart';

abstract class PopularServicesState extends Equatable {
  const PopularServicesState();
  
  @override
  List<Object?> get props => [];
}

class PopularServicesLoading extends PopularServicesState {}

class PopularServicesError extends PopularServicesState {
  final Object error;

  const PopularServicesError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

class PopularServicesErrorKomplat extends PopularServicesState {
  final RequestType request;
  final int? errorCode;
  final String? errorText;

  const PopularServicesErrorKomplat({
    required this.request,
    required this.errorCode,
    required this.errorText
  });

  @override
  List<Object?> get props => [request, errorCode, errorText];
}

class PopularServicesLoaded extends PopularServicesState {
  final List<ListPopularResponsePayRecord> payRecords;

  const PopularServicesLoaded({
    required this.payRecords
  });

  @override
  List<Object?> get props => [payRecords];
}

