// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'rule_allocation_insert_bloc.dart';

abstract class RuleAllocationInsertState extends Equatable {
  const RuleAllocationInsertState();
  
  @override
  List<Object?> get props => [];
}

class RuleAllocationInsertLoading extends RuleAllocationInsertState {}

class RuleAllocationInsertInitial extends RuleAllocationInsertState {
  final List<DataSource> dataSources;
  final List<ArchiveLocation> archiveLocations;

  const RuleAllocationInsertInitial({
    required this.dataSources,
    required this.archiveLocations
  });

  @override
  List<Object?> get props => [dataSources, archiveLocations];
}

class RuleAllocationInsertSuccess extends RuleAllocationInsertState {
  final RuleAllocationData ruleAllocationdata;

  const RuleAllocationInsertSuccess({
    required this.ruleAllocationdata,
  });

  @override
  List<Object?> get props => [ruleAllocationdata];
}

class RuleAllocationInsertNetworkError extends RuleAllocationInsertState {
  final Object? error;

  const RuleAllocationInsertNetworkError({
    required this.error
  });

  @override
  List<Object?> get props => [error];  
}


