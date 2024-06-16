part of 'rule_allocation_update_bloc.dart';

abstract class RuleAllocationUpdateState extends Equatable {
  const RuleAllocationUpdateState();
  
  @override
  List<Object?> get props => [];
}

class RuleAllocationUpdateInitial extends RuleAllocationUpdateState {
  final RuleAllocationData? ruleAllocationData;
  final List<DataSource> dataSources;
  final List<ArchiveLocation> archiveLocations;

  const RuleAllocationUpdateInitial({
    required this.ruleAllocationData,
    required this.dataSources,
    required this.archiveLocations
  });

  @override
  List<Object?> get props => [ruleAllocationData, dataSources, archiveLocations];
}

class RuleAllocationUpdateLoading extends RuleAllocationUpdateState {}


class RuleAllocationUpdateSuccess extends RuleAllocationUpdateState {
  final RuleAllocationData? ruleAllocationData;

  const RuleAllocationUpdateSuccess({required this.ruleAllocationData});

  @override
  List<Object?> get props => [ruleAllocationData];
}

class RuleAllocationUpdateNetworkError extends RuleAllocationUpdateState {
  final Object? error;

  const RuleAllocationUpdateNetworkError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}

