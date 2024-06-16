part of 'features_bloc.dart';

class FeaturesState extends Equatable {
  final bool availableFeatures;
  final String? organizationTitle;
  final String? organizationUnp;
  final bool isPollAvailable;

  const FeaturesState({
    this.availableFeatures = false,
    this.organizationTitle,
    this.organizationUnp,
    this.isPollAvailable = false,
  });
  
  @override
  List<Object?> get props => [
    availableFeatures,
    organizationTitle,
    organizationUnp,
    isPollAvailable
  ];
}
