part of 'info_supplier_bloc.dart';

@immutable
abstract class InfoSupplierState extends Equatable {
  const InfoSupplierState();

  @override
  List<Object?> get props => [];
}

class InfoSupplierInitial extends InfoSupplierState {}

class InfoSupplierLoading extends InfoSupplierState {}

class InfoSupplierLoaded extends InfoSupplierState {
  final List<InfoSupplierResponseCompany> companies;

  const InfoSupplierLoaded({
    required this.companies,
  });

  @override
  List<Object?> get props => [companies];
}

class InfoSupplierError extends InfoSupplierState {
  final Object? error;

  const InfoSupplierError({this.error});

  @override
  List<Object?> get props => [error];
}

class InfoSupplierErrorKomplat extends InfoSupplierState {
  final String errorMessage;
  final int errorCode;

  const InfoSupplierErrorKomplat(
      {required this.errorMessage, required this.errorCode});

  @override
  List<Object> get props => [errorMessage, errorCode];
}
