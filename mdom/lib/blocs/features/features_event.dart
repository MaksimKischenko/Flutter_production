part of 'features_bloc.dart';

abstract class FeaturesEvent extends Equatable {
  const FeaturesEvent();

  @override
  List<Object> get props => [];
}

class FeaturesInit extends FeaturesEvent {}